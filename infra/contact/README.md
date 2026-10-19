# Portfolio infra (S3 + CloudFront + SES contact API)

- **サイト**: S3 + CloudFront + ACM + Route53 → `https://jun01t-portfolio.jun01t.com`
- **お問い合わせ**: API Gateway + Lambda + SES
- **スパム対策**: honeypot + Cloudflare Turnstile（推奨）+ レート制限（主は API Gateway スロットル、Lambda 内 Map は補助）
- **費用ガード**: API スロットル、Lambda 同時実行上限、月次 Budgets アラート（既定 $5）

Vercel は使いません（`*.vercel.app` は AWS ドメインへ 308 リダイレクト）。

## 構成図

```mermaid
flowchart LR
  subgraph dns [DNS / TLS]
    R53[Route53]
    ACM[ACM us-east-1]
  end

  subgraph web [Website]
    CF[CloudFront]
    S3[(S3 static)]
  end

  subgraph api [Contact]
    GW[API Gateway]
    L[Lambda]
    SES[SES]
  end

  TS[Cloudflare Turnstile]
  User([User]) --> R53
  R53 --> CF
  ACM -.-> CF
  CF -->|OAC| S3

  User -->|CAPTCHA| TS
  User -->|POST /contact| GW
  GW --> L
  L -->|verify| TS
  L --> SES
```

デプロイフロー:

```mermaid
flowchart LR
  Dev[Local / CI] -->|pnpm generate| Dist[dist/]
  Dist -->|aws s3 sync| S3[(S3)]
  Dist -.->|invalidation| CF[CloudFront]
  Dev -->|pnpm apply:infra| TF[Terraform]
  TF --> GW[API / Lambda / SES / Budgets]
  TF --> CF
  TF --> S3
```

## 前提

1. 有効な AWS 認証（期限切れならターミナルで `aws login`）
2. Route53 に `jun01t.com` ホストゾーンがあること
3. リポジトリルートで `pnpm install` 済みであること
4. （推奨）Cloudflare Turnstile の site / secret キー

## Turnstile キー

[Turnstile ダッシュボード](https://dash.cloudflare.com/?to=/:account/turnstile) で Widget を作成し、`terraform.tfvars` に設定:

```hcl
turnstile_site_key   = "..."
turnstile_secret_key = "..."
```

未設定でも honeypot のみで動作します。

## Terraform state の保存先（S3 backend）

Terraform **1.10 以上**を `infra/.bin/terraform` に配置してください。state は専用 S3 バケットで共有し、`use_lockfile = true` で同時更新を防ぎます。DynamoDB テーブルは不要です。

事前に、利用する AWS アカウントに state 用 S3 バケットを用意してください。この構成が作るサイト配信用バケットとは分け、バージョニング・暗号化・パブリックアクセスの全面ブロックを有効にしてください。backend は `terraform init` 時点で必要なので、この構成自身では作成しません。

```bash
# リポジトリルートから（初回のみ。既存ファイルは上書きしない）
cp -n infra/contact/backend.hcl.example infra/contact/backend.hcl
# backend.hcl の bucket は terraform.jun01t.com。region を実際のバケットに合わせる
# key は同じインフラを操作する全員で統一する
bash scripts/init-infra.sh
```

`backend.hcl` は Git 管理対象外です。AWS 認証は既存のプロファイルなどで渡し、認証情報はこのファイルに記載しないでください。backend の region は state バケットのリージョンであり、アプリの `aws_region` とは別です。

操作する認証主体には、state バケットの `s3:ListBucket`、state オブジェクトの `s3:GetObject` / `s3:PutObject`、同じ key に `.tflock` を付けたロックオブジェクトの `s3:GetObject` / `s3:PutObject` / `s3:DeleteObject` が必要です。カスタマー管理 KMS キーを使う場合は対応する KMS 権限も付与してください。サイト配信専用の GitHub Actions ロールに state アクセス権は不要です。

### 既存のローカル state を移行する場合

既存環境の **最新のローカル state がある作業ディレクトリ**で実行してください。空のチェックアウトから先に apply しないでください。

1. 全員の Terraform 操作を止め、`terraform.tfstate` とバックアップを安全な場所にコピーする（state にはシークレットが含まれます）。
2. 上記の `backend.hcl` を用意する。
3. `infra/contact` で `../.bin/terraform init -migrate-state -backend-config=backend.hcl` を実行し、移行の確認に回答する。
4. `../.bin/terraform state list` と `../.bin/terraform plan` で既存リソースが認識されることを確認する。意図しない再作成があれば apply しない。

他の作業ディレクトリは移行完了後に `bash scripts/init-infra.sh` で接続します。`-reconfigure` は既存 state を移行しないため、移行の代わりに使わないでください。バケット・key を後から変更する場合も state の移行が必要です。

## 1. Terraform apply

```bash
# リポジトリルートから
pnpm run apply:infra
```

手動の場合:

```bash
# リポジトリルートから
bash scripts/pack-lambda.sh
cd infra/contact
../.bin/terraform init -backend-config=backend.hcl
../.bin/terraform apply
```

apply 後:

1. `terraform.tfvars` の `from_email` に届く **SES 検証メール** のリンクを開く
2. output の `contact_api_url` / `s3_bucket_name` / `cloudfront_distribution_id` を控える

## 2. サイトをデプロイ

リポジトリルートで:

```bash
pnpm run deploy:aws
```

`deploy:aws` は `nuxt generate` → S3 sync → CloudFront invalidation を実行します。  
`TURNSTILE_SITE_KEY` も Terraform output から渡します。

`master` / `main` への push では GitHub Actions（`.github/workflows/deploy.yml`）が同じ処理を自動実行します。  
認証は GitHub OIDC（`jun01t-portfolio-github-deploy` ロール）で、アクセスキーは使いません。

### GitHub Actions Variables（必須）

リポジトリの **Settings → Secrets and variables → Actions → Variables** に設定します（ワークフローに直書きしません）:

| Variable | 例の取得元 |
| --- | --- |
| `AWS_REGION` | `ap-northeast-1` |
| `AWS_DEPLOY_ROLE_ARN` | `terraform output -raw github_deploy_role_arn` |
| `S3_BUCKET` | `terraform output -raw s3_bucket_name` |
| `CLOUDFRONT_DISTRIBUTION_ID` | `terraform output -raw cloudfront_distribution_id` |
| `CONTACT_API_URL` | `terraform output -raw contact_api_url` |
| `TURNSTILE_SITE_KEY` | `terraform output -raw turnstile_site_key`（任意だが推奨） |

OIDC プロバイダとロールを CLI で先に作っている場合、Terraform へ取り込むには:

```bash
cd infra/contact
ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"
../.bin/terraform import aws_iam_openid_connect_provider.github \
  "arn:aws:iam::${ACCOUNT_ID}:oidc-provider/token.actions.githubusercontent.com"
../.bin/terraform import aws_iam_role.github_deploy jun01t-portfolio-github-deploy
../.bin/terraform import aws_iam_role_policy.github_deploy jun01t-portfolio-github-deploy:jun01t-portfolio-github-deploy
```

## 手動デプロイ例

```bash
export CONTACT_API_URL="$(cd infra/contact && ../.bin/terraform output -raw contact_api_url)"
export TURNSTILE_SITE_KEY="$(cd infra/contact && ../.bin/terraform output -raw turnstile_site_key)"
pnpm run generate
aws s3 sync dist/ "s3://$(cd infra/contact && ../.bin/terraform output -raw s3_bucket_name)/" --delete
aws cloudfront create-invalidation \
  --distribution-id "$(cd infra/contact && ../.bin/terraform output -raw cloudfront_distribution_id)" \
  --paths "/*"
```

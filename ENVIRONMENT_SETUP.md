# 環境変数・デプロイ設定

ホスティングは **S3 + CloudFront**、お問い合わせは **SES（API Gateway + Lambda）** です。Vercel は使いません。

## 必要な環境変数（ビルド時）

```bash
CONTACT_API_URL=https://xxxxxxxx.execute-api.ap-northeast-1.amazonaws.com/contact
TURNSTILE_SITE_KEY=0x4AAAA...   # Cloudflare Turnstile のサイトキー
```

`CONTACT_API_URL` は `infra/contact` で `terraform apply` したあとの output `contact_api_url` です。  
`pnpm run deploy:aws` を使う場合は Terraform output から `CONTACT_API_URL` / `TURNSTILE_SITE_KEY` を自動取得します。

### GitHub Actions Variables

自動デプロイ（`.github/workflows/deploy.yml`）は次のリポジトリ Variables を参照します（直書きしません）:

- `AWS_REGION`
- `AWS_DEPLOY_ROLE_ARN`
- `S3_BUCKET`
- `CLOUDFRONT_DISTRIBUTION_ID`
- `CONTACT_API_URL`
- `TURNSTILE_SITE_KEY`（推奨）

値は `infra/contact` の Terraform output から設定します。詳細は [infra/contact/README.md](./infra/contact/README.md) を参照。

## スパム対策

- **Honeypot**: 非表示フィールド。ボットが埋めるとメールは送らず成功レスポンスのみ返す
- **Cloudflare Turnstile**: 人による操作確認。シークレットは Lambda 環境変数のみ
- **件名ホワイトリスト / 文字数制限**
- **レート制限**: 主は API Gateway の stage throttling。Lambda 内の IP Map はインスタンス単位の補助のみ

## 費用ガード

- API Gateway: 既定 5 req/s（バースト 10）← 問い合わせ洪水の主制御
- Lambda: 同時実行上限 5
- AWS Budgets: 月 $5 の 80% / 100% / 予測超過で `budget_alert_email` に通知（初回は確認メールあり）

### Turnstile のセットアップ

1. [Cloudflare Turnstile](https://dash.cloudflare.com/?to=/:account/turnstile) で Widget を作成
2. Hostname に `jun01t-portfolio.jun01t.com`（ローカル確認なら `localhost` も）を追加
3. `infra/contact/terraform.tfvars` に追記:

```hcl
turnstile_site_key   = "サイトキー"
turnstile_secret_key = "シークレットキー"
```

4. `pnpm run apply:infra` → `pnpm run deploy:aws`

シークレット未設定の間は honeypot のみで動作します（Turnstile ウィジェットは出ません）。

## ローカル開発

```bash
# .env
CONTACT_API_URL=https://xxxxxxxx.execute-api.ap-northeast-1.amazonaws.com/contact
TURNSTILE_SITE_KEY=0x4AAAA...
pnpm run dev
```

## 初回セットアップ

1. AWS 認証を有効化（`aws login` など）。GitHub Actions からの自動デプロイは OIDC ロール（`apply:infra` で作成）を使う
2. Turnstile キーを `terraform.tfvars` に設定（推奨）
3. リポジトリルートで `pnpm run apply:infra`（Lambda zip 作成 → Terraform apply）
4. SES 検証メール（`terraform.tfvars` の `from_email`）を承認
5. リポジトリルートで `pnpm run deploy:aws`

## 公開 URL

`https://jun01t-portfolio.jun01t.com`

Route53 / ACM / CloudFront は Terraform（`infra/contact/hosting.tf`）が作成します。

詳細は [infra/contact/README.md](./infra/contact/README.md) を参照してください。

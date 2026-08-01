# 環境変数・デプロイ設定

ホスティングは **S3 + CloudFront**、お問い合わせは **SES（API Gateway + Lambda）** です。Vercel は使いません。

## 必要な環境変数（ビルド時）

```bash
CONTACT_API_URL=https://xxxxxxxx.execute-api.ap-northeast-1.amazonaws.com/contact
```

`CONTACT_API_URL` は `infra/contact` で `terraform apply` したあとの output `contact_api_url` です。  
`pnpm run deploy:aws` を使う場合は Terraform output から自動取得します。

## ローカル開発

```bash
# .env
CONTACT_API_URL=https://xxxxxxxx.execute-api.ap-northeast-1.amazonaws.com/contact
pnpm run dev
```

## 初回セットアップ

1. AWS 認証を有効化（`aws login` など）
2. `cd infra/contact/lambda && pnpm install --prod`
3. `cd .. && ../../.bin/terraform init && ../../.bin/terraform apply`
4. SES 検証メール（`tmdjnch0901@gmail.com`）を承認
5. リポジトリルートで `pnpm run deploy:aws`

## 公開 URL

`https://jun01t-portfolio.jun01t.com`

Route53 / ACM / CloudFront は Terraform（`infra/contact/hosting.tf`）が作成します。

詳細は [infra/contact/README.md](./infra/contact/README.md) を参照してください。

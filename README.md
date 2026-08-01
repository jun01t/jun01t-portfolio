# jun01t Portfolio

Nuxt 3 静的サイト。ホスティングは **S3 + CloudFront**、お問い合わせは **SES（API Gateway + Lambda）**。

公開 URL: `https://jun01t-portfolio.jun01t.com`

インフラ: [infra/contact/README.md](./infra/contact/README.md)  
環境変数: [ENVIRONMENT_SETUP.md](./ENVIRONMENT_SETUP.md)

パッケージマネージャは **pnpm**（`packageManager` で 9.15.9 を指定）。

```bash
corepack enable
pnpm install
aws login                 # AWS 認証が切れている場合
pnpm run apply:infra      # Terraform apply + SES identity
# SES 検証メールを承認してから:
pnpm run deploy:aws       # generate → S3 sync → CloudFront invalidation
```

## Setup

```bash
corepack enable
pnpm install
```

## Development Server

Start the development server on `http://localhost:3000`:

```bash
pnpm run dev
```

## Production

Build the application for production:

```bash
pnpm run build
```

Locally preview production build:

```bash
pnpm run preview
```

Check out the [deployment documentation](https://nuxt.com/docs/getting-started/deployment) for more information.

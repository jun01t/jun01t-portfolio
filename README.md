# jun01t Portfolio

Nuxt 3 静的サイト。ホスティングは **S3 + CloudFront**、お問い合わせは **SES（API Gateway + Lambda）**。

公開 URL: `https://jun01t-portfolio.jun01t.com`

インフラ: [infra/contact/README.md](./infra/contact/README.md)  
環境変数: [ENVIRONMENT_SETUP.md](./ENVIRONMENT_SETUP.md)

```bash
aws login                 # AWS 認証が切れている場合
npm run apply:infra       # Terraform apply + SES identity
# SES 検証メールを承認してから:
npm run deploy:aws        # generate → S3 sync → CloudFront invalidation
```


## Setup

Make sure to install the dependencies:

```bash
# npm
npm install

# pnpm
pnpm install

# yarn
yarn install

# bun
bun install
```

## Development Server

Start the development server on `http://localhost:3000`:

```bash
# npm
npm run dev

# pnpm
pnpm run dev

# yarn
yarn dev

# bun
bun run dev
```

## Production

Build the application for production:

```bash
# npm
npm run build

# pnpm
pnpm run build

# yarn
yarn build

# bun
bun run build
```

Locally preview production build:

```bash
# npm
npm run preview

# pnpm
pnpm run preview

# yarn
yarn preview

# bun
bun run preview
```

Check out the [deployment documentation](https://nuxt.com/docs/getting-started/deployment) for more information.

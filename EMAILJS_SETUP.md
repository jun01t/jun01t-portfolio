# EmailJS設定手順

このポートフォリオサイトのお問い合わせフォームでEmailJSを使用してメール送信機能を実装しています。

## 1. EmailJSアカウント作成

1. [EmailJS](https://www.emailjs.com/)にアクセス
2. アカウントを作成（無料プランで十分）

## 2. メールサービス設定

1. EmailJSダッシュボードで「Email Services」を選択
2. 「Add New Service」をクリック
3. Gmailを選択して設定
4. Service IDを取得（例：`service_portfolio`）

## 3. メールテンプレート作成

1. 「Email Templates」を選択
2. 「Create New Template」をクリック
3. 以下のテンプレートを作成：

```
件名: ポートフォリオサイトからのお問い合わせ

お名前: {{from_name}}
メールアドレス: {{from_email}}
件名: {{subject}}

メッセージ:
{{message}}

---
このメールはポートフォリオサイトのお問い合わせフォームから送信されました。
```

4. Template IDを取得（例：`template_contact`）

## 4. 公開キー取得

1. 「Account」→「General」を選択
2. Public Keyを取得

## 5. コード内の設定更新

`pages/index.vue`の以下の部分を実際の値に更新：

```javascript
const EMAILJS_SERVICE_ID = 'your_service_id'
const EMAILJS_TEMPLATE_ID = 'your_template_id'
const EMAILJS_PUBLIC_KEY = 'your_public_key'
```

### 環境変数での設定（推奨）

Vercelの環境変数で設定する場合：
- `EMAILJS_SERVICE_ID`: あなたのサービスID
- `EMAILJS_TEMPLATE_ID`: あなたのテンプレートID
- `EMAILJS_PUBLIC_KEY`: あなたの公開キー

## 6. 送信先メールアドレス設定

テンプレート内で送信先メールアドレス（`tmdjnch0901@gmail.com`）を設定してください。

## 7. 環境変数設定

### ローカル開発環境

プロジェクトルートに `.env` ファイルを作成：

```bash
# EmailJS設定
EMAILJS_SERVICE_ID=your_service_id
EMAILJS_TEMPLATE_ID=your_template_id
EMAILJS_PUBLIC_KEY=your_public_key_here
```

### Vercelデプロイ環境

Vercelダッシュボードで以下の環境変数を設定：

| 変数名 | 値 | 環境 |
|--------|-----|------|
| `EMAILJS_SERVICE_ID` | `service_id` | Production, Preview, Development |
| `EMAILJS_TEMPLATE_ID` | `your_template_id` | Production, Preview, Development |
| `EMAILJS_PUBLIC_KEY` | `your_public_key_here` | Production, Preview, Development |

詳細は [ENVIRONMENT_SETUP.md](./ENVIRONMENT_SETUP.md) を参照してください。

## 注意事項

- 無料プランでは月100通まで送信可能
- 本番環境では環境変数を使用することを推奨
- スパム対策のため、reCAPTCHAの実装も検討してください
- `.env` ファイルはGitにコミットしないでください

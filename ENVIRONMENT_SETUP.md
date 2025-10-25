# 環境変数設定

このポートフォリオサイトでEmailJSを使用するための環境変数設定手順です。

## 必要な環境変数

以下の環境変数を設定してください：

```bash
EMAILJS_SERVICE_ID=your_service_id
EMAILJS_TEMPLATE_ID=your_template_id
EMAILJS_PUBLIC_KEY=your_public_key_here
```

## 設定方法

### 1. ローカル開発環境

プロジェクトルートに `.env` ファイルを作成し、以下の内容を記述：

```bash
# EmailJS設定
EMAILJS_SERVICE_ID=your_service_id
EMAILJS_TEMPLATE_ID=your_template_id
EMAILJS_PUBLIC_KEY=your_public_key_here
```

### 2. Vercelデプロイ環境

Vercelダッシュボードで以下の環境変数を設定：

1. Vercelダッシュボードにログイン
2. プロジェクトを選択
3. 「Settings」→「Environment Variables」を選択
4. 以下の変数を追加：

| 変数名 | 値 | 環境 |
|--------|-----|------|
| `EMAILJS_SERVICE_ID` | `your_service_id` | Production, Preview, Development |
| `EMAILJS_TEMPLATE_ID` | `your_template_id` | Production, Preview, Development |
| `EMAILJS_PUBLIC_KEY` | `your_public_key_here` | Production, Preview, Development |

### 3. 環境変数の取得方法

#### EmailJS Service ID
- EmailJSダッシュボード → Email Services
- サービスIDを取得

#### EmailJS Template ID
- EmailJSダッシュボード → Email Templates
- テンプレート作成後に取得

#### EmailJS Public Key
- EmailJSダッシュボード → Account → General
- Public Keyを取得

## 注意事項

- **セキュリティ**: 実の値はコードに直接記述しないでください
- **環境変数**: 必ずVercelの環境変数で設定してください
- **Git管理**: `.env` ファイルはGitにコミットしないでください
- **機密情報**: 公開キーは機密情報なので、適切に管理してください
- **デフォルト値**: コード内のデフォルト値はプレースホルダーのままにしてください

## 設定確認

環境変数が正しく設定されているか確認するには、ブラウザの開発者ツールのコンソールで以下を実行：

```javascript
console.log('Service ID:', process.env.EMAILJS_SERVICE_ID)
console.log('Template ID:', process.env.EMAILJS_TEMPLATE_ID)
console.log('Public Key:', process.env.EMAILJS_PUBLIC_KEY)
```

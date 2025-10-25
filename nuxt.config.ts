// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: true },
  modules: [
    '@nuxtjs/tailwindcss'
  ],
  // 静的サイト生成の設定
  ssr: false,
  nitro: {
    prerender: {
      routes: ['/']
    },
    preset: 'static'
  },
  // 環境変数の設定
  runtimeConfig: {
    public: {
      EMAILJS_SERVICE_ID: process.env.EMAILJS_SERVICE_ID || 'your_service_id',
      EMAILJS_TEMPLATE_ID: process.env.EMAILJS_TEMPLATE_ID || 'your_template_id',
      EMAILJS_PUBLIC_KEY: process.env.EMAILJS_PUBLIC_KEY || 'your_public_key_here'
    }
  },
  // アセットの設定
  app: {
    head: {
      title: "jun01t's Portfolio",
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        { name: 'description', content: 'jun01tのポートフォリオサイト' }
      ]
    }
  }
})

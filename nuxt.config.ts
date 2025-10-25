// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: true },
  modules: [
    '@nuxtjs/tailwindcss'
  ],
  // Vercel用の設定
  nitro: {
    preset: 'vercel'
  },
  // 静的サイト生成の設定
  ssr: true,
  // ビルド設定
  build: {
    transpile: ['@nuxtjs/tailwindcss']
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

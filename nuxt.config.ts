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

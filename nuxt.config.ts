// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: true },
  modules: [
    '@nuxtjs/tailwindcss',
    '@zadigetvoltaire/nuxt-gtm'
  ],
  // SPAモードの設定
  ssr: false,
  nitro: {
    preset: 'static'
  },
  // 環境変数の設定
  runtimeConfig: {
    public: {
      CONTACT_API_URL: process.env.CONTACT_API_URL || '',
      TURNSTILE_SITE_KEY: process.env.TURNSTILE_SITE_KEY || '',
    }
  },
  // Google Tag Managerの設定
  gtm: {
    id: 'GTM-5N5Q7V74'
  },
  // アセットの設定
  app: {
    head: {
      title: "jun01t's Portfolio",
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        { name: 'description', content: 'jun01tのポートフォリオサイト' }
      ],
      link: [
        { rel: 'icon', type: 'image/png', href: '/favicon-32.png' },
        { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' },
        { rel: 'apple-touch-icon', href: '/apple-touch-icon.png' },
        { rel: 'preconnect', href: 'https://fonts.googleapis.com' },
        { rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: 'anonymous' },
        {
          rel: 'stylesheet',
          href: 'https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@400;500&family=Space+Grotesk:wght@700&family=Syne:wght@600;700;800&display=swap'
        }
      ]
    }
  }
})

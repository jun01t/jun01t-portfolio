<template>
    <header>
        <title>jun01t's Portfolio</title>
    </header>

    <!-- ハンバーガーメニュー -->
    <nav class="fixed top-0 left-0 w-full z-50 bg-gray-800 bg-opacity-90">
        <div class="flex justify-between items-center px-4 py-2">
            <div class="text-white font-bold text-lg sm:text-xl">jun01t's Portfolio</div>
            <button type="button" @click="toggleMenu"
                class="text-white p-2 focus:outline-none transition-transform duration-300"
                :class="{ 'transform rotate-90': isMenuOpen }"
                :aria-expanded="isMenuOpen" aria-controls="site-menu"
                :aria-label="isMenuOpen ? 'メニューを閉じる' : 'メニューを開く'">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16">
                    </path>
                </svg>
            </button>
        </div>

        <!-- メニューコンテンツ -->
        <div id="site-menu" v-show="isMenuOpen"
            class="bg-gray-800 bg-opacity-95 border-t border-gray-700 max-h-96 overflow-y-auto scrollbar-thin scrollbar-thumb-gray-500 scrollbar-track-gray-700 hover:scrollbar-thumb-gray-400 scrollable-indicator">
            <div class="px-4 py-4">
                <div class="flex items-center justify-between mb-4">
                    <h3 class="text-white text-lg font-bold">成果物</h3>
                    <div class="flex items-center text-gray-400 text-xs">
                        <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M7 16l-4-4m0 0 4-4m0 0l4 4m-4-4v18"></path>
                        </svg>
                        スクロール可能
                    </div>
                </div>
                <div class="space-y-3">
                    <div v-for="project in projects" :key="project.id"
                        class="bg-gray-700 rounded-lg p-3 sm:p-4 hover:bg-gray-600 transition-colors">
                        <h4 class="text-white font-semibold text-base sm:text-lg">{{ project.title }}</h4>
                        <p class="text-gray-300 text-xs sm:text-sm mt-1">{{ project.description }}</p>
                        <div class="flex flex-wrap gap-1 sm:gap-2 mt-2">
                            <span v-for="tech in project.technologies" :key="tech"
                                class="bg-blue-600 text-white text-xs px-2 py-1 rounded">
                                {{ tech }}
                            </span>
                        </div>
                        <div class="mt-3 flex flex-col sm:flex-row gap-2">
                            <a v-if="project.githubUrl" :href="project.githubUrl" target="_blank"
                                class="text-blue-400 hover:text-blue-300 text-xs sm:text-sm inline-flex items-center">
                                <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 24 24">
                                    <path
                                        d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z" />
                                </svg>
                                GitHub
                            </a>
                            <a v-if="project.demoUrl" :href="project.demoUrl" target="_blank"
                                class="text-green-400 hover:text-green-300 text-xs sm:text-sm inline-flex items-center">
                                <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
                                </svg>
                                デモ
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <!-- メニューが開いている時の背景オーバーレイ -->
    <div v-if="isMenuOpen" @click="closeMenu" class="fixed inset-0 bg-black bg-opacity-50 z-40"></div>

    <!-- ヒーローセクション（夏 × スタイリッシュ × エンジニア） -->
    <section class="hero relative min-h-screen flex items-center justify-center overflow-hidden"
        :style="{ '--hero-bg': `url(${backgroundImage})` }">
        <div class="hero__media" aria-hidden="true"></div>
        <div class="hero__grade" aria-hidden="true"></div>
        <div class="hero__grid" aria-hidden="true"></div>
        <div class="hero__sun" aria-hidden="true"></div>

        <div class="hero__content relative z-10 text-center px-4 max-w-3xl mx-auto">
            <div class="hero__avatar mx-auto mb-7 overflow-hidden">
                <img :src="profileImage" alt="jun01t" class="w-full h-full object-cover"
                    fetchpriority="high" decoding="async" />
            </div>

            <p class="hero__mono mb-4">software_engineer · summer_build</p>

            <h1 class="hero__brand mb-4">jun01t</h1>

            <p class="hero__lead mb-10">
                プロダクトを速く、美しく、動くものとして届ける。
            </p>

            <div class="hero__cta flex flex-col sm:flex-row gap-3 justify-center">
                <button type="button" @click="scrollToProjects" class="hero__btn hero__btn--primary">
                    成果物を見る
                </button>
                <button type="button" @click="scrollToContact" class="hero__btn hero__btn--ghost">
                    お問い合わせ
                </button>
            </div>
        </div>
    </section>

    <!-- 成果物セクション -->
    <div id="projects" class="py-20 bg-gray-50">
        <div class="max-w-6xl mx-auto px-4">
            <h2 class="text-4xl font-bold text-center mb-16 text-gray-800">成果物</h2>

            <!-- 成果物一覧 -->
            <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8 mb-16">
                <div v-for="project in projects" :key="project.id"
                    class="bg-white rounded-2xl p-6 shadow-lg hover:shadow-xl transition-shadow duration-300">
                    <h3 class="text-xl font-bold text-gray-800 mb-3">{{ project.title }}</h3>
                    <p class="text-gray-600 mb-4">{{ project.description }}</p>

                    <!-- 技術スタック -->
                    <div class="flex flex-wrap gap-2 mb-4">
                        <span v-for="tech in project.technologies" :key="tech"
                            class="bg-blue-100 text-blue-800 text-xs px-2 py-1 rounded-full">
                            {{ tech }}
                        </span>
                    </div>

                    <!-- リンクボタン -->
                    <div class="flex gap-3">
                        <a v-if="project.githubUrl" :href="project.githubUrl" target="_blank"
                            class="flex items-center px-4 py-2 bg-gray-800 text-white rounded-lg hover:bg-gray-700 transition-colors">
                            <svg class="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 24 24">
                                <path
                                    d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z" />
                            </svg>
                            GitHub
                        </a>
                        <a v-if="project.demoUrl" :href="project.demoUrl" target="_blank"
                            class="flex items-center px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 transition-colors">
                            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
                            </svg>
                            デモ
                        </a>
                    </div>
                </div>
            </div>

            <h2 class="text-4xl font-bold text-center mb-16 text-gray-800">Skills & Expertise</h2>

            <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
                <!-- 職業 -->
                <div class="bg-white rounded-2xl p-8 shadow-lg hover:shadow-xl transition-shadow duration-300">
                    <div class="flex items-center mb-6">
                        <img class="w-8 h-8 mr-4" :src="programmerIcon" alt="プログラマー" loading="lazy"
                            decoding="async" />
                        <h3 class="text-2xl font-bold text-gray-800">職業</h3>
                    </div>
                    <ul class="space-y-3">
                        <li class="flex items-center text-gray-600">
                            <div class="w-2 h-2 bg-blue-500 rounded-full mr-3"></div>
                            ソフトウェアエンジニア
                        </li>
                    </ul>
                </div>

                <!-- フレームワーク -->
                <div class="bg-white rounded-2xl p-8 shadow-lg hover:shadow-xl transition-shadow duration-300">
                    <div class="flex items-center mb-6">
                        <img class="w-8 h-8 mr-4" :src="webappIcon" alt="ウェブアプリ" loading="lazy"
                            decoding="async" />
                        <h3 class="text-2xl font-bold text-gray-800">フレームワーク</h3>
                    </div>
                    <ul class="space-y-3">
                        <li class="flex items-center text-gray-600">
                            <div class="w-2 h-2 bg-red-500 rounded-full mr-3"></div>
                            Ruby on Rails
                        </li>
                        <li class="flex items-center text-gray-600">
                            <div class="w-2 h-2 bg-green-500 rounded-full mr-3"></div>
                            Nuxt.js (Vue.js)
                        </li>
                    </ul>
                </div>

                <!-- プログラミング言語 -->
                <div class="bg-white rounded-2xl p-8 shadow-lg hover:shadow-xl transition-shadow duration-300">
                    <div class="flex items-center mb-6">
                        <img class="w-8 h-8 mr-4" :src="languageIcon" alt="プログラミング言語" loading="lazy"
                            decoding="async" />
                        <h3 class="text-2xl font-bold text-gray-800">言語</h3>
                    </div>
                    <ul class="space-y-3">
                        <li class="flex items-center text-gray-600">
                            <div class="w-2 h-2 bg-red-500 rounded-full mr-3"></div>
                            Ruby
                        </li>
                        <li class="flex items-center text-gray-600">
                            <div class="w-2 h-2 bg-blue-500 rounded-full mr-3"></div>
                            TypeScript
                        </li>
                        <li class="flex items-center text-gray-600">
                            <div class="w-2 h-2 bg-purple-500 rounded-full mr-3"></div>
                            PHP
                        </li>
                        <li class="flex items-center text-gray-600">
                            <div class="w-2 h-2 bg-orange-500 rounded-full mr-3"></div>
                            Java
                        </li>
                        <li class="flex items-center text-gray-600">
                            <div class="w-2 h-2 bg-pink-500 rounded-full mr-3"></div>
                            HTML/CSS
                        </li>
                    </ul>
                </div>

                <!-- データベース -->
                <div class="bg-white rounded-2xl p-8 shadow-lg hover:shadow-xl transition-shadow duration-300">
                    <div class="flex items-center mb-6">
                        <img class="w-8 h-8 mr-4" :src="databaseIcon" alt="データベース" loading="lazy"
                            decoding="async" />
                        <h3 class="text-2xl font-bold text-gray-800">データベース</h3>
                    </div>
                    <ul class="space-y-3">
                        <li class="flex items-center text-gray-600">
                            <div class="w-2 h-2 bg-blue-600 rounded-full mr-3"></div>
                            PostgreSQL
                        </li>
                        <li class="flex items-center text-gray-600">
                            <div class="w-2 h-2 bg-red-600 rounded-full mr-3"></div>
                            Oracle
                        </li>
                        <li class="flex items-center text-gray-600">
                            <div class="w-2 h-2 bg-orange-500 rounded-full mr-3"></div>
                            MySQL
                        </li>
                    </ul>
                </div>

                <!-- クラウド -->
                <div class="bg-white rounded-2xl p-8 shadow-lg hover:shadow-xl transition-shadow duration-300">
                    <div class="flex items-center mb-6">
                        <img class="w-8 h-8 mr-4" :src="awsIcon" alt="AWS" loading="lazy" decoding="async" />
                        <h3 class="text-2xl font-bold text-gray-800">クラウド</h3>
                    </div>
                    <ul class="space-y-3">
                        <li class="flex items-center text-gray-600">
                            <div class="w-2 h-2 bg-orange-500 rounded-full mr-3"></div>
                            AWS
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <!-- お問い合わせセクション -->
    <div id="contact" class="py-20 bg-white">
        <div class="max-w-4xl mx-auto px-4">
            <div class="text-center mb-16">
                <h2 class="text-4xl font-bold text-gray-800 mb-4">お問い合わせ</h2>
                <p class="text-xl text-gray-600">プロジェクトのご相談やお仕事のご依頼はお気軽にご連絡ください</p>
            </div>

            <div class="grid lg:grid-cols-2 gap-12">
                <!-- お問い合わせフォーム -->
                <div class="bg-gray-50 rounded-2xl p-8">
                    <form @submit.prevent="submitForm" class="space-y-6 relative">
                        <!-- Honeypot: leave empty. Hidden from humans, bots often fill it. -->
                        <div class="contact-hp" aria-hidden="true">
                            <label for="website">Website</label>
                            <input id="website" v-model="form.website" type="text" name="website" tabindex="-1"
                                autocomplete="off" />
                        </div>

                        <div>
                            <label for="name" class="block text-sm font-medium text-gray-700 mb-2">お名前 *</label>
                            <input type="text" id="name" v-model="form.name" required maxlength="100"
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-300"
                                placeholder="山田太郎">
                        </div>

                        <div>
                            <label for="email" class="block text-sm font-medium text-gray-700 mb-2">メールアドレス *</label>
                            <input type="email" id="email" v-model="form.email" required maxlength="254"
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-300"
                                placeholder="example@example.com">
                        </div>

                        <div>
                            <label for="subject" class="block text-sm font-medium text-gray-700 mb-2">件名 *</label>
                            <div class="relative">
                                <select id="subject" v-model="form.subject" required
                                    class="w-full px-4 py-3 border border-gray-300 rounded-lg pr-10 focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-300 appearance-none">
                                    <option value="">選択してください</option>
                                    <option value="web-development">Web開発のご相談</option>
                                    <option value="consulting">技術コンサルティング</option>
                                    <option value="collaboration">コラボレーション</option>
                                    <option value="other">その他</option>
                                </select>
                                <div class="pointer-events-none absolute inset-y-0 right-4 flex items-center">
                                    <svg class="h-4 w-4 text-gray-500" viewBox="0 0 20 20" fill="currentColor"
                                        aria-hidden="true">
                                        <path fill-rule="evenodd"
                                            d="M5.23 7.21a.75.75 0 0 1 1.06.02L10 10.94l3.71-3.71a.75.75 0 1 1 1.08 1.04l-4.24 4.24a.75.75 0 0 1-1.06 0L5.21 8.27a.75.75 0 0 1 .02-1.06Z"
                                            clip-rule="evenodd" />
                                    </svg>
                                </div>
                            </div>
                        </div>

                        <div>
                            <label for="message" class="block text-sm font-medium text-gray-700 mb-2">メッセージ *</label>
                            <textarea id="message" v-model="form.message" required rows="5" minlength="10"
                                maxlength="5000"
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-300 resize-none"
                                placeholder="プロジェクトの詳細やご要望をお聞かせください"></textarea>
                        </div>

                        <div v-if="TURNSTILE_SITE_KEY" class="flex justify-start">
                            <div ref="turnstileEl" class="cf-turnstile"></div>
                        </div>

                        <button type="submit" :disabled="isSubmitting || !canSubmit"
                            class="w-full bg-gradient-to-r from-blue-500 to-purple-600 text-white font-semibold py-3 px-6 rounded-lg hover:from-blue-600 hover:to-purple-700 disabled:opacity-50 disabled:cursor-not-allowed transition-all duration-300 transform hover:scale-105">
                            <span v-if="!isSubmitting">送信する</span>
                            <span v-else class="flex items-center justify-center">
                                <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white"
                                    xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor"
                                        stroke-width="4"></circle>
                                    <path class="opacity-75" fill="currentColor"
                                        d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z">
                                    </path>
                                </svg>
                                送信中...
                            </span>
                        </button>
                    </form>
                </div>

                <!-- 連絡先情報 -->
                <div class="space-y-8">
                    <div class="bg-gradient-to-br from-blue-50 to-purple-50 rounded-2xl p-8">
                        <h3 class="text-2xl font-bold text-gray-800 mb-6">連絡先情報</h3>

                        <div class="space-y-6">
                            <div class="flex items-center">
                                <div class="w-12 h-12 bg-green-500 rounded-full flex items-center justify-center mr-4">
                                    <svg class="w-6 h-6 text-white" fill="currentColor" viewBox="0 0 24 24">
                                        <path
                                            d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z" />
                                    </svg>
                                </div>
                                <div>
                                    <h4 class="font-semibold text-gray-800">GitHub</h4>
                                    <a href="https://github.com/jun01t" target="_blank"
                                        class="text-gray-600 hover:text-gray-800 transition-colors">
                                        github.com/jun01t
                                    </a>
                                </div>
                            </div>

                            <div class="flex items-center">
                                <div
                                    class="w-12 h-12 bg-white rounded-full flex items-center justify-center mr-4 shadow-lg">
                                        <img :src="soundcloudIcon" alt="SoundCloud" class="w-8 h-8" loading="lazy"
                                            decoding="async" />
                                </div>
                                <div>
                                    <h4 class="font-semibold text-gray-800">SoundCloud</h4>
                                    <a href="https://soundcloud.com/jun01t" target="_blank"
                                        class="text-gray-600 hover:text-gray-800 transition-colors">
                                        soundcloud.com/jun01t
                                    </a>
                                </div>
                            </div>

                            <div class="flex items-center">
                                <div
                                    class="w-12 h-12 bg-white rounded-full flex items-center justify-center mr-4 shadow-lg">
                                    <svg class="w-6 h-6" fill="#333" viewBox="0 0 300 300">
                                        <path
                                            d="M149.999 248.909c-54.537 0-98.906-44.367-98.906-98.909 0-54.537 44.369-98.909 98.906-98.909 54.545 0 98.908 44.372 98.908 98.909 0 54.542-44.363 98.909-98.908 98.909zm0-185.238c-47.601 0-86.33 38.723-86.33 86.329 0 47.605 38.729 86.332 86.33 86.332 47.61 0 86.338-38.727 86.338-86.332 0-47.606-38.728-86.329-86.338-86.329zM161.52 101.16c-4.832-9.785-7.783-19.3-9.273-24.845v70.055c2.447.917 4.197 3.257 4.197 6.021 0 3.559-2.887 6.442-6.443 6.442-3.56 0-6.443-2.885-6.443-6.442 0-2.896 1.925-5.317 4.558-6.131v-70.019c-1.485 5.531-4.438 15.092-9.293 24.919-7.571 15.314-17.009 28.823-17.009 28.823l6.036 82.598s5.736 6.401 22.31 6.41h.023c16.573-.009 22.312-6.41 22.312-6.41l6.035-82.598c-.003 0-9.441-13.508-17.01-28.823z" />
                                    </svg>
                                </div>
                                <div>
                                    <h4 class="font-semibold text-gray-800">はてなブログ</h4>
                                    <a href="https://blog.jun01t.com/" target="_blank"
                                        class="text-gray-600 hover:text-gray-800 transition-colors">
                                        blog.jun01t.com
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="bg-gray-50 rounded-2xl p-8">
                        <h3 class="text-2xl font-bold text-gray-800 mb-4">対応可能なサービス</h3>
                        <ul class="space-y-3">
                            <li class="flex items-center text-gray-600">
                                <div class="w-2 h-2 bg-blue-500 rounded-full mr-3"></div>
                                Webアプリケーション開発
                            </li>
                            <li class="flex items-center text-gray-600">
                                <div class="w-2 h-2 bg-green-500 rounded-full mr-3"></div>
                                フロントエンド開発
                            </li>
                            <li class="flex items-center text-gray-600">
                                <div class="w-2 h-2 bg-purple-500 rounded-full mr-3"></div>
                                技術コンサルティング
                            </li>
                            <li class="flex items-center text-gray-600">
                                <div class="w-2 h-2 bg-orange-500 rounded-full mr-3"></div>
                                コードレビュー
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- フッター -->
    <footer class="site-footer">
        <div class="site-footer__grid" aria-hidden="true"></div>
        <div class="relative z-10 max-w-6xl mx-auto px-4 py-16">
            <div class="text-center">
                <p class="site-footer__mono mb-3">built_with_care · summer_build</p>
                <h3 class="site-footer__brand mb-3">jun01t</h3>
                <p class="site-footer__lead mb-8">Software Engineer & Creative Developer</p>

                <div class="flex justify-center gap-5 mb-10">
                    <a href="https://github.com/jun01t" target="_blank" rel="noopener noreferrer"
                        class="site-footer__social" aria-label="GitHub">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path
                                d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z" />
                        </svg>
                    </a>
                    <a href="https://soundcloud.com/jun01t" target="_blank" rel="noopener noreferrer"
                        class="site-footer__social" aria-label="SoundCloud">
                        <img :src="soundcloudIcon" alt="" class="w-5 h-5" loading="lazy" decoding="async" />
                    </a>
                    <a href="https://www.youtube.com/@jun01t" target="_blank" rel="noopener noreferrer"
                        class="site-footer__social" aria-label="YouTube">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path
                                d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z" />
                        </svg>
                    </a>
                    <a href="https://blog.jun01t.com/" target="_blank" rel="noopener noreferrer"
                        class="site-footer__social" aria-label="はてなブログ">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 300 300" aria-hidden="true">
                            <path
                                d="M149.999 248.909c-54.537 0-98.906-44.367-98.906-98.909 0-54.537 44.369-98.909 98.906-98.909 54.545 0 98.908 44.372 98.908 98.909 0 54.542-44.363 98.909-98.908 98.909zm0-185.238c-47.601 0-86.33 38.723-86.33 86.329 0 47.605 38.729 86.332 86.33 86.332 47.61 0 86.338-38.727 86.338-86.332 0-47.606-38.728-86.329-86.338-86.329zM161.52 101.16c-4.832-9.785-7.783-19.3-9.273-24.845v70.055c2.447.917 4.197 3.257 4.197 6.021 0 3.559-2.887 6.442-6.443 6.442-3.56 0-6.443-2.885-6.443-6.442 0-2.896 1.925-5.317 4.558-6.131v-70.019c-1.485 5.531-4.438 15.092-9.293 24.919-7.571 15.314-17.009 28.823-17.009 28.823l6.036 82.598s5.736 6.401 22.31 6.41h.023c16.573-.009 22.312-6.41 22.312-6.41l6.035-82.598c-.003 0-9.441-13.508-17.01-28.823z" />
                        </svg>
                    </a>
                </div>

                <div class="site-footer__rule pt-8">
                    <p class="site-footer__copy">© 2026 jun01t. All rights reserved.</p>
                </div>
            </div>
        </div>
    </footer>
</template>

<script setup lang="ts">
import { computed, nextTick, onBeforeUnmount, onMounted, ref, type Ref } from 'vue'

// 画像のインポート
import programmerIcon from '~/assets/img/icons8-プログラマー-50.png'
import webappIcon from '~/assets/img/icons8-ウェブアプリ-64.png'
import languageIcon from '~/assets/img/icons8-プログラミング言語-50.png'
import databaseIcon from '~/assets/img/icons8-データベース-50.png'
import awsIcon from '~/assets/img/icons8-アマゾンウェブサービス-32.png'
import soundcloudIcon from '~/public/assets/img/icons8-soundcloud-48.png'
import profileImage from '~/public/assets/img/icon-name.webp'
import backgroundImage from '~/public/assets/img/coding-man.webp'

type TurnstileApi = {
    render: (el: HTMLElement, options: Record<string, unknown>) => string | number
    reset: (widgetId?: string | number) => void
    remove: (widgetId?: string | number) => void
}

declare global {
    interface Window {
        turnstile?: TurnstileApi
    }
}

// メニューの開閉状態
const isMenuOpen: Ref<boolean> = ref(false)

// メニューの開閉機能
const toggleMenu = (): void => {
    isMenuOpen.value = !isMenuOpen.value
}

// メニューを閉じる機能
const closeMenu = (): void => {
    isMenuOpen.value = false
}

// お問い合わせフォームの状態
const isSubmitting: Ref<boolean> = ref(false)
const turnstileToken: Ref<string> = ref('')
const turnstileEl: Ref<HTMLElement | null> = ref(null)
const formOpenedAt = Date.now()
let turnstileWidgetId: string | number | null = null

// フォームデータ
type ContactForm = {
    name: string
    email: string
    subject: string
    message: string
    website: string
}

const form: Ref<ContactForm> = ref({
    name: '',
    email: '',
    subject: '',
    message: '',
    website: '',
})

const config = useRuntimeConfig()
const CONTACT_API_URL = String(config.public.CONTACT_API_URL || '').trim()
const TURNSTILE_SITE_KEY = String(config.public.TURNSTILE_SITE_KEY || '').trim()

const canSubmit = computed(() => {
    if (!TURNSTILE_SITE_KEY) return true
    return Boolean(turnstileToken.value)
})

const loadTurnstileScript = (): Promise<void> => {
    if (window.turnstile) return Promise.resolve()
    return new Promise((resolve, reject) => {
        const existing = document.querySelector<HTMLScriptElement>('script[data-turnstile]')
        if (existing) {
            existing.addEventListener('load', () => resolve(), { once: true })
            existing.addEventListener('error', () => reject(new Error('Turnstile script failed')), { once: true })
            return
        }
        const script = document.createElement('script')
        script.src = 'https://challenges.cloudflare.com/turnstile/v0/api.js?render=explicit'
        script.async = true
        script.defer = true
        script.dataset.turnstile = 'true'
        script.onload = () => resolve()
        script.onerror = () => reject(new Error('Turnstile script failed'))
        document.head.appendChild(script)
    })
}

const renderTurnstile = async (): Promise<void> => {
    if (!TURNSTILE_SITE_KEY) return
    await loadTurnstileScript()
    await nextTick()
    if (!turnstileEl.value || !window.turnstile) return
    if (turnstileWidgetId !== null) {
        window.turnstile.remove(turnstileWidgetId)
        turnstileWidgetId = null
    }
    turnstileWidgetId = window.turnstile.render(turnstileEl.value, {
        sitekey: TURNSTILE_SITE_KEY,
        theme: 'light',
        callback: (token: string) => {
            turnstileToken.value = token
        },
        'expired-callback': () => {
            turnstileToken.value = ''
        },
        'error-callback': () => {
            turnstileToken.value = ''
        },
    })
}

const resetTurnstile = (): void => {
    turnstileToken.value = ''
    if (turnstileWidgetId !== null && window.turnstile) {
        window.turnstile.reset(turnstileWidgetId)
    }
}

onMounted(() => {
    void renderTurnstile().catch((err) => console.error(err))
})

onBeforeUnmount(() => {
    if (turnstileWidgetId !== null && window.turnstile) {
        window.turnstile.remove(turnstileWidgetId)
    }
})

// スクロール関数
const scrollToProjects = (): void => {
    const projectsSection = document.getElementById('projects')
    if (projectsSection) {
        projectsSection.scrollIntoView({ behavior: 'smooth' })
    }
}

const scrollToContact = (): void => {
    const contactSection = document.getElementById('contact')
    if (contactSection) {
        contactSection.scrollIntoView({ behavior: 'smooth' })
    }
}

// フォーム送信処理（AWS SES via API Gateway）
const submitForm = async (): Promise<void> => {
    isSubmitting.value = true

    try {
        if (!CONTACT_API_URL) {
            throw new Error('お問い合わせ API の設定が完了していません。管理者にお問い合わせください。')
        }

        // Soft client-side throttle for naive bots (server honeypot / Turnstile are the real checks)
        if (Date.now() - formOpenedAt < 2500) {
            throw new Error('送信が早すぎます。内容を確認してから再度お試しください。')
        }

        if (TURNSTILE_SITE_KEY && !turnstileToken.value) {
            throw new Error('CAPTCHA を完了してください。')
        }

        const response = await fetch(CONTACT_API_URL, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                name: form.value.name,
                email: form.value.email,
                subject: form.value.subject,
                message: form.value.message,
                website: form.value.website,
                turnstileToken: turnstileToken.value,
            }),
        })

        if (!response.ok) {
            let detail = ''
            try {
                const payload = await response.json()
                detail = String(payload?.error ?? '')
            } catch {
                detail = ''
            }
            throw new Error(detail || `Request failed (${response.status})`)
        }

        alert('お問い合わせありがとうございます！\n内容を確認の上、2-3営業日以内にご返信いたします。')

        form.value = {
            name: '',
            email: '',
            subject: '',
            message: '',
            website: '',
        }
        resetTurnstile()
    } catch (err: unknown) {
        console.error('送信エラー:', err)

        const message = (err as Error)?.message ?? ''
        let errorMessage = '送信に失敗しました。もう一度お試しください。'

        if (message.includes('設定が完了')) {
            errorMessage = 'メール送信の設定に問題があります。管理者にお問い合わせください。'
        } else if (/CAPTCHA|captcha/i.test(message)) {
            errorMessage = 'スパム対策の確認に失敗しました。もう一度チェックしてから送信してください。'
            resetTurnstile()
        } else if (/早すぎ/i.test(message)) {
            errorMessage = message
        } else if (/too many|429/i.test(message)) {
            errorMessage = '送信上限に達している可能性があります。しばらくしてから再度お試しください。'
        } else if (/network|Failed to fetch/i.test(message)) {
            errorMessage = 'ネットワークエラーが発生しました。インターネット接続を確認してください。'
        }

        alert(errorMessage)
    } finally {
        isSubmitting.value = false
    }
}


// 成果物のデータ
type Project = {
    id: number
    title: string
    description: string
    technologies: string[]
    githubUrl: string | null
    demoUrl: string | null
}

const projects: Ref<Project[]> = ref([
    {
        id: 1,
        title: 'ポートフォリオサイト（Nuxt.js）',
        description: 'このポートフォリオサイト自体。レスポンシブデザインとモダンなUIを実装。',
        technologies: ['Nuxt.js', 'Vue.js', 'Tailwind CSS', 'TypeScript'],
        githubUrl: 'https://github.com/jun01t/jun01t-portfolio',
        demoUrl: 'https://jun01t-portfolio.jun01t.com'
    },
    {
        id: 2,
        title: 'CSVビューアー（Vue.js）',
        description: 'CSVファイルをアップロードして表形式で表示・編集できるWebアプリケーション。データの検索・フィルタリング機能付き。',
        technologies: ['Nuxt.js', 'Vue.js', 'Tailwind CSS', 'JavaScript', 'HTML5', 'CSS3'],
        githubUrl: 'https://github.com/jun01t/csv-viewer',
        demoUrl: 'https://t.co/JCV7h3xCRR'
    },
    {
        id: 3,
        title: '技術ブログ（はてなブログ）',
        description: 'WebAssembly、プログラミング、技術トレンドについて発信する技術ブログ。Web開発の知見や最新技術の解説記事を執筆。',
        technologies: ['はてなブログ', 'Markdown', '技術記事', 'WebAssembly', 'プログラミング'],
        githubUrl: null,
        demoUrl: 'https://blog.jun01t.com/'
    },
    {
        id: 4,
        title: '音楽制作（SoundCloud）',
        description: '音楽制作・楽曲配信プラットフォーム。オリジナル楽曲の制作・公開を行い、音楽活動を通じてクリエイティブな表現を追求。',
        technologies: ['SoundCloud', '音楽制作', '楽曲配信', 'クリエイティブ', '音響技術'],
        githubUrl: null,
        demoUrl: 'https://soundcloud.com/jun01t'
    },
    {
        id: 5,
        title: '動画制作（YouTube）',
        description: 'YouTubeチャンネルでの動画制作・配信活動。技術解説、チュートリアル、クリエイティブなコンテンツ制作を通じて知識共有と表現活動を展開。',
        technologies: ['YouTube', '動画制作', 'コンテンツ制作', '映像編集', '配信技術'],
        githubUrl: null,
        demoUrl: 'https://www.youtube.com/@jun01t'
    },
    {
        id: 6,
        title: 'Weather Outfit Suggestor',
        description: '天気情報に基づいて最適な服装を提案するWebアプリケーション。気温に応じたコーディネート提案と快適に過ごすためのアドバイスを提供。',
        technologies: ['Vue.js', 'Vite', 'Tailwind CSS', 'JavaScript', 'OpenWeatherMap API'],
        githubUrl: 'https://github.com/jun01t/weather-outfit-suggestor',
        demoUrl: 'https://weather-outfit-suggestor.vercel.app'
    },
    {
        id: 7,
        title: '今年は閏年？',
        description: '指定した年が閏年かどうかを判定するうるう年チェックサイト。閏年は4で割り切れて100で割り切れない年、または400で割り切れる年で判定。',
        technologies: ['Vue.js', 'Vite', 'Tailwind CSS', 'JavaScript'],
        githubUrl: 'https://github.com/jun01t/leap-year-site',
        demoUrl: 'https://leap-year-site.vercel.app/'
    },
    {
        id: 8,
        title: '婚活偏差値診断（AI）',
        description:
            '質問に答えてAIが婚活の偏差値・傾向を診断するWebアプリ。フロントは Next.js（App Router）、API は Go（Chi）または同一オリジンの Route Handlers。',
        technologies: ['Next.js', 'Go', 'TypeScript', 'Chi'],
        githubUrl: 'https://github.com/jun01t/konkatsu-diagnosis',
        demoUrl: 'https://konkatsu-diagnosis-glbxolozp-jun01ts-projects.vercel.app/'
    },
    {
        id: 9,
        title: 'favicon-getter',
        description:
            '指定したサイトの favicon を URL・サイズ指定で取得するツール。CLI・API・Web UI を用意し、Vercel にデプロイ。',
        technologies: ['Node.js', 'JavaScript', 'Vercel', 'HTML/CSS'],
        githubUrl: 'https://github.com/jun01t/favicon-getter',
        demoUrl: 'https://favicon-getter.vercel.app'
    },
])
</script>

<style lang="scss" scoped>
/* キービジュアル：夏のシアン／アンバー × エンジニアグリッド */
.contact-hp {
    position: absolute;
    left: -10000px;
    top: auto;
    width: 1px;
    height: 1px;
    overflow: hidden;
}

.hero {
    --hero-ink: #e8f7f4;
    --hero-cyan: #2ec4b6;
    --hero-sky: #5eead4;
    --hero-sun: #f5a524;
    --hero-deep: #042f2e;
    font-family: 'Syne', sans-serif;
    color: var(--hero-ink);
}

.hero__media {
    position: absolute;
    inset: 0;
    background-image: var(--hero-bg);
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    transform: scale(1.04);
    animation: hero-drift 28s ease-in-out infinite alternate;
}

.hero__grade {
    position: absolute;
    inset: 0;
    background:
        linear-gradient(165deg, rgba(4, 47, 46, 0.72) 0%, rgba(8, 68, 78, 0.55) 42%, rgba(15, 90, 100, 0.45) 100%),
        linear-gradient(25deg, rgba(245, 165, 36, 0.28) 0%, transparent 38%),
        linear-gradient(to top, rgba(4, 30, 32, 0.75) 0%, transparent 45%);
}

.hero__grid {
    position: absolute;
    inset: 0;
    opacity: 0.22;
    background-image:
        linear-gradient(rgba(94, 234, 212, 0.35) 1px, transparent 1px),
        linear-gradient(90deg, rgba(94, 234, 212, 0.35) 1px, transparent 1px);
    background-size: 48px 48px;
    mask-image: radial-gradient(ellipse 70% 60% at 50% 45%, #000 20%, transparent 75%);
    animation: hero-grid 18s linear infinite;
}

.hero__sun {
    position: absolute;
    top: -12%;
    right: -8%;
    width: min(52vw, 420px);
    height: min(52vw, 420px);
    border-radius: 50%;
    background: radial-gradient(circle, rgba(245, 165, 36, 0.55) 0%, rgba(46, 196, 182, 0.18) 42%, transparent 70%);
    filter: blur(8px);
    animation: hero-sun 12s ease-in-out infinite alternate;
    pointer-events: none;
}

.hero__content {
    animation: hero-rise 0.9s cubic-bezier(0.22, 1, 0.36, 1) both;
}

.hero__avatar {
    width: 7.5rem;
    height: 7.5rem;
    border-radius: 50%;
    border: 2px solid rgba(94, 234, 212, 0.55);
    box-shadow: 0 0 0 6px rgba(4, 47, 46, 0.35);
}

.hero__mono {
    font-family: 'IBM Plex Mono', ui-monospace, monospace;
    font-size: 0.75rem;
    letter-spacing: 0.14em;
    text-transform: lowercase;
    color: rgba(94, 234, 212, 0.9);
}

.hero__brand {
    font-family: 'Space Grotesk', sans-serif;
    font-size: clamp(3.25rem, 10vw, 5.5rem);
    font-weight: 700;
    line-height: 1.15;
    letter-spacing: -0.04em;
    padding-bottom: 0.08em;
    background: linear-gradient(120deg, #fff 10%, var(--hero-sky) 48%, var(--hero-sun) 92%);
    -webkit-background-clip: text;
    background-clip: text;
    color: transparent;
}

.hero__lead {
    font-family: 'IBM Plex Mono', ui-monospace, monospace;
    font-size: clamp(0.95rem, 2.4vw, 1.15rem);
    line-height: 1.7;
    color: rgba(232, 247, 244, 0.88);
    max-width: 28rem;
    margin-left: auto;
    margin-right: auto;
}

.hero__btn {
    min-width: 10.5rem;
    padding: 0.85rem 1.5rem;
    font-family: 'Syne', sans-serif;
    font-weight: 700;
    font-size: 0.95rem;
    letter-spacing: 0.02em;
    border-radius: 0.35rem;
    transition: transform 0.25s ease, background-color 0.25s ease, color 0.25s ease, border-color 0.25s ease;
}

.hero__btn:hover {
    transform: translateY(-2px);
}

.hero__btn--primary {
    background: var(--hero-cyan);
    color: var(--hero-deep);
    border: 1px solid transparent;
}

.hero__btn--primary:hover {
    background: var(--hero-sky);
}

.hero__btn--ghost {
    background: transparent;
    color: var(--hero-ink);
    border: 1px solid rgba(232, 247, 244, 0.55);
}

.hero__btn--ghost:hover {
    border-color: var(--hero-sky);
    color: var(--hero-sky);
}

@keyframes hero-rise {
    from {
        opacity: 0;
        transform: translateY(1.25rem);
    }

    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes hero-drift {
    from {
        transform: scale(1.04) translate3d(0, 0, 0);
    }

    to {
        transform: scale(1.08) translate3d(-1.5%, -1%, 0);
    }
}

@keyframes hero-grid {
    from {
        background-position: 0 0;
    }

    to {
        background-position: 48px 48px;
    }
}

@keyframes hero-sun {
    from {
        opacity: 0.75;
        transform: translate3d(0, 0, 0) scale(1);
    }

    to {
        opacity: 1;
        transform: translate3d(-4%, 6%, 0) scale(1.08);
    }
}

@media (prefers-reduced-motion: reduce) {
    .hero__media,
    .hero__grid,
    .hero__sun,
    .hero__content {
        animation: none;
    }
}

/* フッター：ヒーローと同系の夏 × エンジニア */
.site-footer {
    --footer-ink: #e8f7f4;
    --footer-cyan: #2ec4b6;
    --footer-sky: #5eead4;
    --footer-sun: #f5a524;
    --footer-deep: #042f2e;
    position: relative;
    overflow: hidden;
    background:
        linear-gradient(180deg, #063836 0%, var(--footer-deep) 55%, #021c1b 100%);
    color: var(--footer-ink);
    font-family: 'Syne', sans-serif;
}

.site-footer__grid {
    position: absolute;
    inset: 0;
    opacity: 0.12;
    background-image:
        linear-gradient(rgba(94, 234, 212, 0.4) 1px, transparent 1px),
        linear-gradient(90deg, rgba(94, 234, 212, 0.4) 1px, transparent 1px);
    background-size: 40px 40px;
    mask-image: linear-gradient(to bottom, transparent, #000 30%, #000 70%, transparent);
    pointer-events: none;
}

.site-footer__mono {
    font-family: 'IBM Plex Mono', ui-monospace, monospace;
    font-size: 0.7rem;
    letter-spacing: 0.14em;
    text-transform: lowercase;
    color: rgba(94, 234, 212, 0.85);
}

.site-footer__brand {
    font-family: 'Space Grotesk', sans-serif;
    font-size: clamp(1.75rem, 4vw, 2.25rem);
    font-weight: 700;
    letter-spacing: -0.04em;
    line-height: 1.15;
    padding-bottom: 0.06em;
    background: linear-gradient(120deg, #fff 10%, var(--footer-sky) 48%, var(--footer-sun) 92%);
    -webkit-background-clip: text;
    background-clip: text;
    color: transparent;
}

.site-footer__lead {
    font-family: 'IBM Plex Mono', ui-monospace, monospace;
    font-size: 0.85rem;
    color: rgba(232, 247, 244, 0.72);
}

.site-footer__social {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 2.5rem;
    height: 2.5rem;
    border-radius: 0.35rem;
    border: 1px solid rgba(232, 247, 244, 0.2);
    color: rgba(232, 247, 244, 0.75);
    transition: color 0.2s ease, border-color 0.2s ease, background-color 0.2s ease, transform 0.2s ease;
}

.site-footer__social:hover {
    color: var(--footer-sky);
    border-color: rgba(94, 234, 212, 0.55);
    background: rgba(46, 196, 182, 0.12);
    transform: translateY(-2px);
}

.site-footer__rule {
    border-top: 1px solid rgba(94, 234, 212, 0.18);
}

.site-footer__copy {
    font-family: 'IBM Plex Mono', ui-monospace, monospace;
    font-size: 0.75rem;
    color: rgba(232, 247, 244, 0.45);
}

/* カスタムスクロールバーのスタイル */
.scrollbar-thin {
    scrollbar-width: thin;
}

.scrollbar-thin::-webkit-scrollbar {
    width: 8px;
}

.scrollbar-thin::-webkit-scrollbar-track {
    background: #374151;
    border-radius: 4px;
}

.scrollbar-thin::-webkit-scrollbar-thumb {
    background: #6b7280;
    border-radius: 4px;
}

.scrollbar-thin::-webkit-scrollbar-thumb:hover {
    background: #9ca3af;
}

/* スクロール可能であることを示すグラデーション */
.scrollable-indicator {
    position: relative;
}

.scrollable-indicator::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    height: 20px;
    background: linear-gradient(transparent, rgba(55, 65, 81, 0.8));
    pointer-events: none;
}
</style>
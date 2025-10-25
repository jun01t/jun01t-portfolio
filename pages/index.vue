<template>
    <header>
        <title>jun01t's Portfolio</title>
    </header>

    <!-- ハンバーガーメニュー -->
    <nav class="fixed top-0 left-0 w-full z-50 bg-gray-800 bg-opacity-90">
        <div class="flex justify-between items-center px-4 py-2">
            <div class="text-white font-bold text-lg sm:text-xl">jun01t's Portfolio</div>
            <button @click="toggleMenu" class="text-white p-2 focus:outline-none transition-transform duration-300"
                :class="{ 'transform rotate-90': isMenuOpen }">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16">
                    </path>
                </svg>
            </button>
        </div>

        <!-- メニューコンテンツ -->
        <div v-show="isMenuOpen"
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

    <!-- ヒーローセクション -->
    <div class="relative min-h-screen flex items-center justify-center overflow-hidden"
        :style="{ backgroundImage: `url(${backgroundImage})`, backgroundRepeat: 'no-repeat', backgroundSize: 'cover', backgroundPosition: 'center' }">
        <!-- オーバーレイ -->
        <div class="absolute inset-0 bg-black bg-opacity-50"></div>

        <!-- メインコンテンツ -->
        <div class="relative z-10 text-center text-white px-4 max-w-4xl mx-auto">
            <!-- プロフィール画像エリア -->
            <div class="mb-8">
                <div
                    class="w-32 h-32 mx-auto mb-6 rounded-full bg-gradient-to-br from-blue-500 to-purple-600 flex items-center justify-center text-6xl font-bold">
                    J
                </div>
                <h1
                    class="text-5xl md:text-6xl font-bold mb-4 bg-gradient-to-r from-blue-400 to-purple-400 bg-clip-text text-transparent">
                    jun01t
                </h1>
                <p class="text-xl md:text-2xl text-gray-200 mb-8">Software Engineer & Creative Developer</p>
            </div>

            <!-- スキルバッジ -->
            <div class="flex flex-wrap justify-center gap-3 mb-12">
                <span class="px-4 py-2 bg-blue-600 bg-opacity-80 rounded-full text-sm font-medium">Vue.js</span>
                <span class="px-4 py-2 bg-green-600 bg-opacity-80 rounded-full text-sm font-medium">Nuxt.js</span>
                <span class="px-4 py-2 bg-red-600 bg-opacity-80 rounded-full text-sm font-medium">Ruby on Rails</span>
                <span class="px-4 py-2 bg-yellow-600 bg-opacity-80 rounded-full text-sm font-medium">JavaScript</span>
                <span class="px-4 py-2 bg-purple-600 bg-opacity-80 rounded-full text-sm font-medium">AWS</span>
            </div>

            <!-- CTAボタン -->
            <div class="flex flex-col sm:flex-row gap-4 justify-center">
                <button @click="scrollToProjects"
                    class="px-8 py-3 bg-gradient-to-r from-blue-500 to-purple-600 rounded-full text-white font-semibold hover:from-blue-600 hover:to-purple-700 transition-all duration-300 transform hover:scale-105">
                    成果物を見る
                </button>
                <button @click="scrollToContact"
                    class="px-8 py-3 border-2 border-white rounded-full text-white font-semibold hover:bg-white hover:text-gray-900 transition-all duration-300">
                    お問い合わせ
                </button>
            </div>
        </div>
    </div>

    <!-- スキルセクション -->
    <div class="py-20 bg-gray-50">
        <div class="max-w-6xl mx-auto px-4">
            <h2 class="text-4xl font-bold text-center mb-16 text-gray-800">Skills & Expertise</h2>

            <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
                <!-- 職業 -->
                <div class="bg-white rounded-2xl p-8 shadow-lg hover:shadow-xl transition-shadow duration-300">
                    <div class="flex items-center mb-6">
                        <img class="w-8 h-8 mr-4" :src="programmerIcon" alt="プログラマー" />
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
                        <img class="w-8 h-8 mr-4" :src="webappIcon" alt="ウェブアプリ" />
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
                        <img class="w-8 h-8 mr-4" :src="languageIcon" alt="プログラミング言語" />
                        <h3 class="text-2xl font-bold text-gray-800">言語</h3>
                    </div>
                    <ul class="space-y-3">
                        <li class="flex items-center text-gray-600">
                            <div class="w-2 h-2 bg-red-500 rounded-full mr-3"></div>
                            Ruby
                        </li>
                        <li class="flex items-center text-gray-600">
                            <div class="w-2 h-2 bg-yellow-500 rounded-full mr-3"></div>
                            JavaScript
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
                        <img class="w-8 h-8 mr-4" :src="databaseIcon" alt="データベース" />
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
                        <img class="w-8 h-8 mr-4" :src="awsIcon" alt="AWS" />
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
    <div class="py-20 bg-white">
        <div class="max-w-4xl mx-auto px-4">
            <div class="text-center mb-16">
                <h2 class="text-4xl font-bold text-gray-800 mb-4">お問い合わせ</h2>
                <p class="text-xl text-gray-600">プロジェクトのご相談やお仕事のご依頼はお気軽にご連絡ください</p>
            </div>

            <div class="grid lg:grid-cols-2 gap-12">
                <!-- お問い合わせフォーム -->
                <div class="bg-gray-50 rounded-2xl p-8">
                    <form @submit.prevent="submitForm" class="space-y-6">
                        <div>
                            <label for="name" class="block text-sm font-medium text-gray-700 mb-2">お名前 *</label>
                            <input type="text" id="name" v-model="form.name" required
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-300"
                                placeholder="山田太郎">
                        </div>

                        <div>
                            <label for="email" class="block text-sm font-medium text-gray-700 mb-2">メールアドレス *</label>
                            <input type="email" id="email" v-model="form.email" required
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-300"
                                placeholder="example@email.com">
                        </div>

                        <div>
                            <label for="subject" class="block text-sm font-medium text-gray-700 mb-2">件名 *</label>
                            <select id="subject" v-model="form.subject" required
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-300">
                                <option value="">選択してください</option>
                                <option value="web-development">Web開発のご相談</option>
                                <option value="consulting">技術コンサルティング</option>
                                <option value="collaboration">コラボレーション</option>
                                <option value="other">その他</option>
                            </select>
                        </div>

                        <div>
                            <label for="message" class="block text-sm font-medium text-gray-700 mb-2">メッセージ *</label>
                            <textarea id="message" v-model="form.message" required rows="5"
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-300 resize-none"
                                placeholder="プロジェクトの詳細やご要望をお聞かせください"></textarea>
                        </div>

                        <button type="submit" :disabled="isSubmitting"
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
                                <div class="w-12 h-12 bg-blue-500 rounded-full flex items-center justify-center mr-4">
                                    <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M3 8l7.89 4.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z">
                                        </path>
                                    </svg>
                                </div>
                                <div>
                                    <h4 class="font-semibold text-gray-800">メール</h4>
                                    <p class="text-gray-600">contact@jun01t.dev</p>
                                </div>
                            </div>

                            <div class="flex items-center">
                                <div class="w-12 h-12 bg-green-500 rounded-full flex items-center justify-center mr-4">
                                    <svg class="w-6 h-6 text-white" fill="currentColor" viewBox="0 0 24 24">
                                        <path
                                            d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z" />
                                    </svg>
                                </div>
                                <div>
                                    <h4 class="font-semibold text-gray-800">GitHub</h4>
                                    <p class="text-gray-600">github.com/jun01t</p>
                                </div>
                            </div>

                            <div class="flex items-center">
                                <div class="w-12 h-12 bg-purple-500 rounded-full flex items-center justify-center mr-4">
                                    <svg class="w-6 h-6 text-white" fill="currentColor" viewBox="0 0 24 24">
                                        <path
                                            d="M12 0C5.373 0 0 5.373 0 12s5.373 12 12 12 12-5.373 12-12S18.627 0 12 0zm5.568 8.16c-.169 0-.315.063-.441.189-.126.126-.189.272-.189.441v7.22c0 .169.063.315.189.441.126.126.272.189.441.189s.315-.063.441-.189c.126-.126.189-.272.189-.441V8.79c0-.169-.063-.315-.189-.441-.126-.126-.272-.189-.441-.189z" />
                                    </svg>
                                </div>
                                <div>
                                    <h4 class="font-semibold text-gray-800">SoundCloud</h4>
                                    <p class="text-gray-600">soundcloud.com/jun01t</p>
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
    <footer class="bg-gray-900 text-white py-16">
        <div class="max-w-6xl mx-auto px-4">
            <div class="text-center">
                <h3
                    class="text-3xl font-bold mb-4 bg-gradient-to-r from-blue-400 to-purple-400 bg-clip-text text-transparent">
                    jun01t's Portfolio
                </h3>
                <p class="text-gray-400 mb-8">Software Engineer & Creative Developer</p>

                <!-- ソーシャルリンク -->
                <div class="flex justify-center space-x-6 mb-8">
                    <a href="https://github.com/jun01t" target="_blank"
                        class="text-gray-400 hover:text-white transition-colors duration-300">
                        <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                            <path
                                d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z" />
                        </svg>
                    </a>
                    <a href="https://soundcloud.com/jun01t" target="_blank"
                        class="text-gray-400 hover:text-white transition-colors duration-300">
                        <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                            <path
                                d="M12 0C5.373 0 0 5.373 0 12s5.373 12 12 12 12-5.373 12-12S18.627 0 12 0zm5.568 8.16c-.169 0-.315.063-.441.189-.126.126-.189.272-.189.441v7.22c0 .169.063.315.189.441.126.126.272.189.441.189s.315-.063.441-.189c.126-.126.189-.272.189-.441V8.79c0-.169-.063-.315-.189-.441-.126-.126-.272-.189-.441-.189z" />
                        </svg>
                    </a>
                    <a href="https://www.youtube.com/@jun01t" target="_blank"
                        class="text-gray-400 hover:text-white transition-colors duration-300">
                        <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                            <path
                                d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z" />
                        </svg>
                    </a>
                </div>

                <div class="border-t border-gray-800 pt-8">
                    <p class="text-gray-500 text-sm">
                        © 2024 jun01t. All rights reserved.
                    </p>
                    <p class="text-gray-600 text-xs mt-2">
                        Background image by <a href="https://jp.freepik.com/free-photo/coding-man_5633683.htm"
                            target="_blank" class="hover:text-gray-400 transition-colors">pressfoto</a> / <a
                            href="https://www.freepik.com" target="_blank"
                            class="hover:text-gray-400 transition-colors">Freepik</a>
                    </p>
                </div>
            </div>
        </div>
    </footer>
</template>

<script setup>
import { ref } from 'vue'

// 画像のインポート
import programmerIcon from '~/assets/img/icons8-プログラマー-50.png'
import webappIcon from '~/assets/img/icons8-ウェブアプリ-64.png'
import languageIcon from '~/assets/img/icons8-プログラミング言語-50.png'
import databaseIcon from '~/assets/img/icons8-データベース-50.png'
import awsIcon from '~/assets/img/icons8-アマゾンウェブサービス-32.png'
import backgroundImage from '~/assets/img/coding-man.jpg'

// メニューの開閉状態
const isMenuOpen = ref(false)

// メニューの開閉機能
const toggleMenu = () => {
    isMenuOpen.value = !isMenuOpen.value
}

// メニューを閉じる機能
const closeMenu = () => {
    isMenuOpen.value = false
}

// お問い合わせフォームの状態
const isSubmitting = ref(false)

// フォームデータ
const form = ref({
    name: '',
    email: '',
    subject: '',
    message: ''
})

// フォーム送信処理
const submitForm = async () => {
    isSubmitting.value = true

    try {
        // 実際の送信処理（ここではコンソールに出力）
        console.log('フォーム送信:', form.value)

        // 送信成功のシミュレーション
        await new Promise(resolve => setTimeout(resolve, 2000))

        // 成功メッセージ
        alert('お問い合わせありがとうございます！\n内容を確認の上、2-3営業日以内にご返信いたします。')

        // フォームリセット
        form.value = {
            name: '',
            email: '',
            subject: '',
            message: ''
        }

    } catch (error) {
        console.error('送信エラー:', error)
        alert('送信に失敗しました。もう一度お試しください。')
    } finally {
        isSubmitting.value = false
    }
}

// スクロール機能
const scrollToProjects = () => {
    const element = document.querySelector('.bg-gray-50')
    if (element) {
        element.scrollIntoView({ behavior: 'smooth' })
    }
}

const scrollToContact = () => {
    const element = document.querySelector('.py-20.bg-white')
    if (element) {
        element.scrollIntoView({ behavior: 'smooth' })
    }
}

// 成果物のデータ
const projects = ref([
    {
        id: 1,
        title: 'ポートフォリオサイト（Nuxt.js）',
        description: 'このポートフォリオサイト自体。レスポンシブデザインとモダンなUIを実装。',
        technologies: ['Nuxt.js', 'Vue.js', 'Tailwind CSS', 'TypeScript'],
        githubUrl: 'https://github.com/jun01t/jun01t-portfolio',
        demoUrl: 'https://jun01t-portfolio.vercel.app'
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
        demoUrl: 'https://t.co/HoN0rgGuKB'
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
])
</script>

<style lang="scss" scoped>
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
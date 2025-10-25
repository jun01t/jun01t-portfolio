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
        <div v-show="isMenuOpen" class="bg-gray-800 bg-opacity-95 border-t border-gray-700 max-h-96 overflow-y-auto">
            <div class="px-4 py-4">
                <h3 class="text-white text-lg font-bold mb-4">成果物</h3>
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

    <div class="text-center font-bold font-serif pb-16 bg-top text-white pt-16">
        <h1 class="h-16 pt-3 text-3xl text-bold bg-gray-600 text-white tracking-wide">jun01t's Portfolio</h1>
        <div>
            <div class="flex w-36 ml-auto mr-auto mt-8">
                <img class="w-5 h-5 mt-9 mr-4" src="/asset/img/icons8-プログラマー-50.png" alt="プログラマー-50" />
                <div class="text-2xl pt-8">職業</div>
            </div>
            <div class="text-xs">
                <a target="_blank" href="https://icons8.com/icon/53381/%E9%96%8B%E7%99%BA%E8%80%85">プログラマー</a>
                アイコン by <a target="_blank" href="https://icons8.com">Icons8</a>
            </div>
            <ul class="pt-4 text-xl font-normal">
                <li class="pt-2">ソフトウェアエンジニア</li>
            </ul>
        </div>
        <div>
            <div class="flex w-52 ml-auto mr-auto mt-4">
                <img class="w-5 h-5 mt-5 mr-4" src="/asset/img/icons8-ウェブアプリ-64.png" alt="ウェブアプリ-64" />
                <div class="text-2xl pt-4">フレームワーク</div>
            </div>
            <div class="text-xs">
                <a target="_blank"
                    href="https://icons8.com/icon/gWFtpuoNEmKs/%E3%82%A6%E3%82%A7%E3%83%96%E3%82%A2%E3%83%97%E3%83%AA">ウェブアプリ</a>
                アイコン by <a target="_blank" href="https://icons8.com">Icons8</a>
            </div>
            <ul class="text-xl pt-4 font-normal">
                <li class="pt-2">Ruby on Rails</li>
                <li class="pt-2">Nuxt.js(Vue.js)</li>
            </ul>
        </div>
        <div>
            <div class="flex w-24 ml-auto mr-auto mt-4">
                <img class="w-5 h-5 mt-5 mr-4" src="/asset/img/icons8-プログラミング言語-50.png" alt="プログラミング言語-50" />
                <div class="text-2xl pt-4">言語</div>
            </div>
            <div class="text-xs">
                <a target="_blank"
                    href="https://icons8.com/icon/22181/ruby%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0%E8%A8%80%E8%AA%9E">プログラミング言語</a>
                アイコン by <a target="_blank" href="https://icons8.com">Icons8</a>
            </div>
            <ul class="text-xl pt-4 font-normal">
                <li class="pt-2">Ruby</li>
                <li class="pt-2">JavaScript</li>
                <li class="pt-2">PHP</li>
                <li class="pt-2">Java</li>
                <li class="pt-2">HTML/CSS</li>
            </ul>
        </div>
        <div>
            <div class="flex w-24 ml-auto mr-auto mt-4">
                <img class="w-5 h-5 mt-5 mr-4" src="/asset/img/icons8-データベース-50.png" alt="データベース-50" />
                <div class="text-2xl pt-4">DB</div>
            </div>
            <div class="text-xs">
                <a target="_blank"
                    href="https://icons8.com/icon/1476/%E3%83%87%E3%83%BC%E3%82%BF%E3%83%99%E3%83%BC%E3%82%B9">データベース</a>
                アイコン by <a target="_blank" href="https://icons8.com">Icons8</a>
            </div>
            <ul class="text-xl pt-4 font-normal">
                <li class="pt-2">PostgreSQL</li>
                <li class="pt-2">Oracle</li>
                <li class="pt-2">MySQL</li>
            </ul>
        </div>
        <div>
            <div class="flex w-24 ml-auto mr-auto mt-4">
                <img class="w-8 h-8 mt-3 mr-4" src="/asset/img/icons8-アマゾンウェブサービス-32.png" alt="アマゾンウェブサービス-32" />
                <div class="text-2xl pt-4">IaaS</div>
            </div>
            <div class="text-xs">
                <a target="_blank"
                    href="https://icons8.com/icon/VoXRGxL3ekkk/%E3%82%A2%E3%83%9E%E3%82%BE%E3%83%B3%E3%82%A6%E3%82%A7%E3%83%96%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9">アマゾンウェブサービス</a>
                アイコン by <a target="_blank" href="https://icons8.com">Icons8</a>
            </div>
            <ul class="text-xl pt-4 font-normal">
                <li class="pt-2">AWS</li>
            </ul>
        </div>
    </div>
    <footer class="h-24 pt-3 text-3xl text-bold bg-gray-600 text-white text-center font-bold font-serif">
        <h1 class="tracking-wide">jun01t's Portfolio
        </h1>
        <div class="text-xs text-white pt-2">
            <a
                href="https://jp.freepik.com/free-photo/coding-man_5633683.htm#query=%E3%82%A8%E3%83%B3%E3%82%B8%E3%83%8B%E3%82%A2&position=2&from_view=search&track=sph&uuid=437375bc-0f20-4a81-9715-1b5d801c1cd5">著作者：pressfoto</a>／出典：Freepik
        </div>
    </footer>
</template>

<script setup>
import { ref } from 'vue'

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

// 成果物のデータ
const projects = ref([
    {
        id: 1,
        title: 'ECサイト（Ruby on Rails）',
        description: '商品管理、注文処理、決済機能を備えたECサイトを開発。管理画面も含む完全なWebアプリケーション。',
        technologies: ['Ruby on Rails', 'PostgreSQL', 'JavaScript', 'Bootstrap'],
        githubUrl: 'https://github.com/example/ec-site',
        demoUrl: 'https://example-ec-site.herokuapp.com'
    },
    {
        id: 2,
        title: 'タスク管理アプリ（Vue.js）',
        description: 'チームでのタスク管理を効率化するWebアプリケーション。リアルタイム更新機能付き。',
        technologies: ['Vue.js', 'Node.js', 'Socket.io', 'MongoDB'],
        githubUrl: 'https://github.com/example/task-manager',
        demoUrl: 'https://task-manager-demo.netlify.app'
    },
    {
        id: 3,
        title: 'API連携システム（Spring Boot）',
        description: '外部APIとの連携を行うバックエンドシステム。認証、データ変換、エラーハンドリング機能を実装。',
        technologies: ['Spring Boot', 'Java', 'MySQL', 'JWT'],
        githubUrl: 'https://github.com/example/api-integration'
    },
    {
        id: 4,
        title: 'ポートフォリオサイト（Nuxt.js）',
        description: 'このポートフォリオサイト自体。レスポンシブデザインとモダンなUIを実装。',
        technologies: ['Nuxt.js', 'Vue.js', 'Tailwind CSS', 'TypeScript'],
        githubUrl: 'https://github.com/example/portfolio',
        demoUrl: 'https://jun01t-portfolio.vercel.app'
    },
    {
        id: 5,
        title: 'CSVビューアー（Vue.js）',
        description: 'CSVファイルをアップロードして表形式で表示・編集できるWebアプリケーション。データの検索・フィルタリング機能付き。',
        technologies: ['Vue.js', 'JavaScript', 'HTML5', 'CSS3'],
        githubUrl: 'https://github.com/example/csv-viewer',
        demoUrl: 'https://csv-viewer-demo.netlify.app'
    }
])
</script>

<style lang="scss" scoped>
.bg-top {
    background-image: url('/asset/img/coding-man.jpg');
    background-repeat: no-repeat;
    background-size: cover;
}
</style>
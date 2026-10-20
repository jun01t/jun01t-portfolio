<template>
    <div class="portfolio" id="top">
        <a class="skip-link" href="#main">本文へスキップ</a>
        <nav
            class="navigation"
            aria-label="メインナビゲーション"
            @keydown.esc="closeMenu"
        >
            <a class="wordmark" href="#top" @click="closeMenu"
                >jun01t<span aria-hidden="true">.</span></a
            >
            <span class="nav-caption">ENGINEERING MEETS CREATIVITY</span>
            <div class="desktop-links">
                <a href="#projects"
                    >Works <span><UiArrow /></span
                ></a>
                <a href="#about">About</a>
                <a href="#contact" class="nav-contact"
                    >Let's talk <span><UiArrow /></span
                ></a>
            </div>
            <button
                class="menu-toggle"
                type="button"
                @click="toggleMenu"
                :aria-expanded="isMenuOpen"
                aria-controls="site-menu"
                :aria-label="isMenuOpen ? 'メニューを閉じる' : 'メニューを開く'"
            >
                {{ isMenuOpen ? 'Close −' : 'Menu +' }}
            </button>
            <div id="site-menu" v-show="isMenuOpen" class="mobile-links">
                <a href="#projects" @click="closeMenu">Works <span>01</span></a>
                <a href="#about" @click="closeMenu">About <span>02</span></a>
                <a href="#contact" @click="closeMenu"
                    >Let's talk <span><UiArrow /></span
                ></a>
            </div>
        </nav>
        <main id="main">
            <section class="hero" aria-labelledby="hero-title">
                <div class="hero-topline">
                    <span
                        ><i class="status-dot"></i> SOFTWARE ENGINEER & CREATIVE
                        DEVELOPER</span
                    ><span>PORTFOLIO — {{ currentYear }}</span>
                </div>
                <div class="hero-layout">
                    <div class="hero-copy">
                        <p class="eyebrow">CODE. CREATE. CONNECT.</p>
                        <h1 id="hero-title">
                            Ideas into<br /><span class="serif">something</span
                            ><br /><span class="last-line"
                                >real<span class="hero-period">.</span
                                ><span class="hero-asterisk" aria-hidden="true"
                                    >✳</span
                                ></span
                            >
                        </h1>
                        <p class="hero-description">
                            アイデアを、触れられるかたちに。<br />コードとクリエイティブで、日常に小さな可能性を。
                        </p>
                        <a class="primary-link" href="#projects"
                            >制作物を見る
                            <span aria-hidden="true"
                                ><UiArrow direction="down-right" /></span
                        ></a>
                    </div>
                    <div
                        class="hero-art"
                        aria-label="技術と創造性が交差する軌道を表現したグラフィック"
                        role="img"
                    >
                        <div class="art-coordinate">
                            FIG. 01 / THE CREATIVE ORBIT
                        </div>
                        <div class="orbit-scene" aria-hidden="true">
                            <div class="orbit orbit-one"></div>
                            <div class="orbit orbit-two"></div>
                            <div class="orbit orbit-three"></div>
                            <div class="orbit-core">
                                <span>j<span class="core-zero">0</span>1</span>
                            </div>
                            <span class="orbit-point point-one"></span
                            ><span class="orbit-point point-two"></span>
                            <div class="art-label label-code">
                                &lt;/&gt; <span>CODE</span>
                            </div>
                            <div class="art-label label-create">
                                ✳ <span>CREATE</span>
                            </div>
                        </div>
                        <div class="art-bottom">
                            <span>LOGIC × INTUITION</span
                            ><span>ALWAYS EXPLORING <UiArrow /></span>
                        </div>
                    </div>
                </div>
                <div class="hero-bottom">
                    <span>WEB DEVELOPMENT · CLOUD · CREATIVE</span
                    ><a href="#projects"
                        >SCROLL TO EXPLORE
                        <span><UiArrow direction="down" /></span
                    ></a>
                </div>
            </section>

            <section
                class="works section-shell"
                id="projects"
                aria-labelledby="works-title"
            >
                <div class="section-topline">
                    <span>01 / SELECTED WORKS</span
                    ><span>A COLLECTION OF THINGS I'VE BUILT</span>
                </div>
                <div class="section-heading">
                    <h2 id="works-title">
                        Built with <span class="serif">curiosity.</span>
                    </h2>
                    <p>
                        つくって、試して、磨いていく。<br />Web
                        アプリから、言葉や音の表現まで。
                    </p>
                </div>
                <div class="works-toolbar">
                    <div class="filters" aria-label="制作物の絞り込み">
                        <button
                            v-for="filter in filters"
                            :key="filter"
                            type="button"
                            :class="{ active: activeFilter === filter }"
                            :aria-pressed="activeFilter === filter"
                            @click="activeFilter = filter"
                        >
                            {{ filter
                            }}<span v-if="filter === 'All'">{{
                                String(projects.length).padStart(2, '0')
                            }}</span>
                        </button>
                    </div>
                    <span class="work-count" role="status" aria-live="polite"
                        >{{
                            String(visibleProjects.length).padStart(2, '0')
                        }}
                        PROJECTS</span
                    >
                </div>
                <div class="project-grid">
                    <article
                        v-for="project in visibleProjects"
                        :key="project.id"
                        class="project-card"
                    >
                        <a
                            :href="
                                project.demoUrl ||
                                project.githubUrl ||
                                '#projects'
                            "
                            target="_blank"
                            rel="noopener noreferrer"
                            class="project-art"
                            :class="`art-${project.id}`"
                            :aria-label="`${project.title} を別タブで開く`"
                        >
                            <div class="project-art-top">
                                <span>{{
                                    categoryFor(project.id).toUpperCase()
                                }}</span
                                ><span>{{
                                    String(project.id).padStart(2, '0')
                                }}</span>
                            </div>
                            <div
                                v-if="project.id === 11"
                                class="vault-decoration"
                                aria-hidden="true"
                            >
                                <i></i><i></i><i></i>
                            </div>
                            <div
                                v-if="project.id === 2"
                                class="csv-decoration"
                                aria-hidden="true"
                            >
                                <span>A</span><span>B</span><span>C</span
                                ><span>01</span><span>02</span><span>03</span
                                ><span>04</span><span>05</span><span>06</span>
                            </div>
                            <div
                                v-if="project.id === 4"
                                class="sound-decoration"
                                aria-hidden="true"
                            >
                                <i
                                    v-for="n in 16"
                                    :key="n"
                                    :style="{
                                        height: `${24 + ((n * 37) % 80)}px`,
                                    }"
                                ></i>
                            </div>
                            <div class="project-art-word">
                                <UiArrow v-if="project.id === 9" /><template
                                    v-else
                                    >{{
                                        artworkLabels[project.id]?.[0]
                                    }}</template
                                >
                            </div>
                            <div class="project-art-bottom">
                                <span>{{ artworkLabels[project.id]?.[1] }}</span
                                ><span class="art-arrow" aria-hidden="true"
                                    ><UiArrow
                                /></span>
                            </div>
                        </a>
                        <div class="project-info">
                            <div class="project-title-row">
                                <h3>{{ project.title }}</h3>
                                <a
                                    v-if="project.githubUrl"
                                    :href="project.githubUrl"
                                    target="_blank"
                                    rel="noopener noreferrer"
                                    class="source-link"
                                    :aria-label="`${project.title} のソースコード`"
                                    >Code <UiArrow
                                /></a>
                            </div>
                            <p>{{ project.description }}</p>
                            <ul class="tech-tags" aria-label="使用技術">
                                <li
                                    v-for="tech in project.technologies"
                                    :key="tech"
                                >
                                    {{ tech }}
                                </li>
                            </ul>
                        </div>
                    </article>
                </div>
                <a
                    class="text-link all-code"
                    href="https://github.com/jun01t"
                    target="_blank"
                    rel="noopener noreferrer"
                    >More experiments on GitHub <span><UiArrow /></span
                ></a>
            </section>

            <section
                class="about section-shell"
                id="about"
                aria-labelledby="about-title"
            >
                <div class="section-topline">
                    <span>02 / A LITTLE ABOUT ME</span
                    ><span>THE PERSON BEHIND THE CODE</span>
                </div>
                <div class="about-intro">
                    <div class="about-heading">
                        <div class="profile-line">
                            <img
                                src="/assets/img/icon-name.webp"
                                alt="jun01t のプロフィール画像"
                                width="56"
                                height="56"
                                loading="lazy"
                            /><span>HELLO, I'M JUN01T.</span>
                        </div>
                        <h2 id="about-title">
                            Engineer by craft.<br /><span class="serif"
                                >Creator at heart.</span
                            >
                        </h2>
                    </div>
                    <div class="about-copy">
                        <span class="about-symbol" aria-hidden="true">✳</span>
                        <p>
                            コードを書くことも、音楽をつくることも。<br />根っこにあるのは「つくってみたい」という好奇心。
                        </p>
                        <p>
                            フロントエンドからバックエンド、クラウドまで。技術を組み合わせてアイデアを動くものにし、使う人にとって心地よい体験を目指しています。
                        </p>
                        <a
                            href="https://github.com/jun01t"
                            target="_blank"
                            rel="noopener noreferrer"
                            class="text-link"
                            >Find me on GitHub <span><UiArrow /></span
                        ></a>
                    </div>
                </div>
                <div class="skill-grid">
                    <article
                        v-for="skill in skillGroups"
                        :key="skill.number"
                        class="skill-card"
                    >
                        <span class="skill-number"
                            >{{ skill.number }} / EXPERTISE</span
                        >
                        <h3>{{ skill.title }}</h3>
                        <p>{{ skill.copy }}</p>
                        <ul>
                            <li v-for="item in skill.items" :key="item">
                                {{ item }}
                            </li>
                        </ul>
                    </article>
                </div>
            </section>

            <section
                class="contact section-shell"
                id="contact"
                aria-labelledby="contact-title"
            >
                <div class="section-topline">
                    <span>03 / GET IN TOUCH</span
                    ><span>GOOD THINGS START WITH A CONVERSATION</span>
                </div>
                <div class="contact-layout">
                    <div class="contact-copy">
                        <p class="eyebrow">HAVE SOMETHING IN MIND?</p>
                        <h2 id="contact-title">
                            Let's make<br /><span class="serif">it happen.</span
                            ><span class="contact-arrow" aria-hidden="true"
                                ><UiArrow
                            /></span>
                        </h2>
                        <p>
                            「こんなものをつくりたい」から、はじめましょう。<br />開発のご相談やコラボレーションなど、<br />お気軽にご連絡ください。
                        </p>
                        <div class="contact-services">
                            <span>WEB DEVELOPMENT</span><span>FRONTEND</span
                            ><span>CONSULTING</span><span>CODE REVIEW</span>
                        </div>
                        <div class="social-links">
                            <a
                                v-for="link in socialLinks"
                                :key="link.label"
                                :href="link.href"
                                target="_blank"
                                rel="noopener noreferrer"
                                >{{ link.label }} <UiArrow
                            /></a>
                        </div>
                    </div>
                    <form
                        @submit.prevent="submitForm"
                        class="contact-form"
                        :aria-busy="isSubmitting"
                    >
                        <div class="contact-hp" aria-hidden="true">
                            <label for="website">Website</label
                            ><input
                                id="website"
                                v-model="form.website"
                                type="text"
                                name="website"
                                tabindex="-1"
                                autocomplete="off"
                            />
                        </div>
                        <div class="form-heading">
                            <span>SEND A MESSAGE</span><span>✳</span>
                        </div>
                        <div class="form-field">
                            <label for="name">お名前 <span>必須</span></label
                            ><input
                                id="name"
                                v-model="form.name"
                                type="text"
                                autocomplete="name"
                                placeholder="山田 太郎"
                                required
                                maxlength="100"
                            />
                        </div>
                        <div class="form-field">
                            <label for="email"
                                >メールアドレス <span>必須</span></label
                            ><input
                                id="email"
                                v-model="form.email"
                                type="email"
                                autocomplete="email"
                                placeholder="hello@example.com"
                                required
                                maxlength="254"
                            />
                        </div>
                        <div class="form-field">
                            <label for="subject"
                                >ご相談内容 <span>必須</span></label
                            ><select
                                id="subject"
                                v-model="form.subject"
                                required
                            >
                                <option value="" disabled>
                                    選択してください
                                </option>
                                <option value="web-development">
                                    Web開発のご相談
                                </option>
                                <option value="consulting">
                                    技術コンサルティング
                                </option>
                                <option value="collaboration">
                                    コラボレーション
                                </option>
                                <option value="other">その他</option>
                            </select>
                        </div>
                        <div class="form-field">
                            <label for="message"
                                >メッセージ <span>必須</span></label
                            ><textarea
                                id="message"
                                v-model="form.message"
                                placeholder="アイデアやご相談内容をお聞かせください（10文字以上）"
                                required
                                rows="4"
                                minlength="10"
                                maxlength="5000"
                            ></textarea>
                        </div>
                        <div v-if="TURNSTILE_SITE_KEY">
                            <div ref="turnstileEl" class="cf-turnstile"></div>
                        </div>
                        <p
                            v-if="formFeedback"
                            class="form-feedback"
                            :class="{ success: formSucceeded }"
                            role="status"
                            aria-live="polite"
                        >
                            {{ formFeedback }}
                        </p>
                        <button
                            class="submit-button"
                            type="submit"
                            :disabled="isSubmitting || !canSubmit"
                        >
                            <span>{{
                                isSubmitting ? '送信中…' : 'メッセージを送る'
                            }}</span
                            ><span aria-hidden="true"><UiArrow /></span>
                        </button>
                    </form>
                </div>
            </section>
        </main>
        <footer class="footer section-shell">
            <div class="footer-top">
                <a class="footer-brand" href="#top"
                    >jun01t<span aria-hidden="true">.</span></a
                >
                <p>A LITTLE LOGIC.<br />A LOT OF CURIOSITY.</p>
                <a class="back-top" href="#top"
                    >BACK TO TOP <UiArrow direction="up"
                /></a>
            </div>
            <div class="footer-bottom">
                <span>© {{ currentYear }} JUN01T</span
                ><span>DESIGNED WITH INTENTION. BUILT WITH CODE.</span
                ><span>THANKS FOR STOPPING BY.</span>
            </div>
        </footer>
    </div>
</template>

<script setup lang="ts">
import {
    ref,
    computed,
    onMounted,
    onBeforeUnmount,
    nextTick,
    type Ref,
} from 'vue'
useHead({
    title: 'jun01t | Software Engineer & Creative Developer',
    htmlAttrs: { lang: 'ja' },
    meta: [
        {
            name: 'description',
            content:
                'アイデアを、触れられるかたちに。jun01t の制作実績とスキルを紹介するポートフォリオ。Web アプリ開発からクラウド、音楽や技術発信まで。',
        },
    ],
})

type TurnstileApi = {
    render: (
        el: HTMLElement,
        options: Record<string, unknown>,
    ) => string | number
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
        const existing = document.querySelector<HTMLScriptElement>(
            'script[data-turnstile]',
        )
        if (existing) {
            if (window.turnstile || existing.dataset.loaded === 'true') {
                resolve()
                return
            }
            existing.addEventListener('load', () => resolve(), { once: true })
            existing.addEventListener(
                'error',
                () => reject(new Error('Turnstile script failed')),
                { once: true },
            )
            return
        }
        const script = document.createElement('script')
        script.src =
            'https://challenges.cloudflare.com/turnstile/v0/api.js?render=explicit'
        script.async = true
        script.defer = true
        script.dataset.turnstile = 'true'
        script.onload = () => {
            script.dataset.loaded = 'true'
            resolve()
        }
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

// フォーム送信処理（AWS SES via API Gateway）
const submitForm = async (): Promise<void> => {
    isSubmitting.value = true
    formFeedback.value = ''
    formSucceeded.value = false

    try {
        if (!CONTACT_API_URL) {
            throw new Error(
                'お問い合わせ API の設定が完了していません。管理者にお問い合わせください。',
            )
        }

        // Soft client-side throttle for naive bots (server honeypot / Turnstile are the real checks)
        if (Date.now() - formOpenedAt < 2500) {
            throw new Error(
                '送信が早すぎます。内容を確認してから再度お試しください。',
            )
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

        formSucceeded.value = true
        formFeedback.value =
            'お問い合わせありがとうございます。内容を確認の上、ご返信いたします。'

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
            errorMessage =
                'メール送信の設定に問題があります。管理者にお問い合わせください。'
        } else if (/CAPTCHA|captcha/i.test(message)) {
            errorMessage =
                'スパム対策の確認に失敗しました。もう一度チェックしてから送信してください。'
            resetTurnstile()
        } else if (/早すぎ/i.test(message)) {
            errorMessage = message
        } else if (/too many|429/i.test(message)) {
            errorMessage =
                '送信上限に達している可能性があります。しばらくしてから再度お試しください。'
        } else if (/network|Failed to fetch/i.test(message)) {
            errorMessage =
                'ネットワークエラーが発生しました。インターネット接続を確認してください。'
        }

        formFeedback.value = errorMessage
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
        description:
            'このポートフォリオサイト自体。レスポンシブデザインとモダンなUIを実装。',
        technologies: ['Nuxt.js', 'Vue.js', 'Tailwind CSS', 'TypeScript'],
        githubUrl: 'https://github.com/jun01t/jun01t-portfolio',
        demoUrl: 'https://jun01t-portfolio.jun01t.com',
    },
    {
        id: 2,
        title: 'CSVビューアー（Vue.js）',
        description:
            'CSVファイルをアップロードして表形式で表示・編集できるWebアプリケーション。データの検索・フィルタリング機能付き。',
        technologies: [
            'Nuxt.js',
            'Vue.js',
            'Tailwind CSS',
            'JavaScript',
            'HTML5',
            'CSS3',
        ],
        githubUrl: 'https://github.com/jun01t/csv-viewer',
        demoUrl: 'https://t.co/JCV7h3xCRR',
    },
    {
        id: 3,
        title: '技術ブログ（はてなブログ）',
        description:
            'WebAssembly、プログラミング、技術トレンドについて発信する技術ブログ。Web開発の知見や最新技術の解説記事を執筆。',
        technologies: [
            'はてなブログ',
            'Markdown',
            '技術記事',
            'WebAssembly',
            'プログラミング',
        ],
        githubUrl: null,
        demoUrl: 'https://blog.jun01t.com/',
    },
    {
        id: 4,
        title: '音楽制作（SoundCloud）',
        description:
            '音楽制作・楽曲配信プラットフォーム。オリジナル楽曲の制作・公開を行い、音楽活動を通じてクリエイティブな表現を追求。',
        technologies: [
            'SoundCloud',
            '音楽制作',
            '楽曲配信',
            'クリエイティブ',
            '音響技術',
        ],
        githubUrl: null,
        demoUrl: 'https://soundcloud.com/jun01t',
    },
    {
        id: 5,
        title: '動画制作（YouTube）',
        description:
            'YouTubeチャンネルでの動画制作・配信活動。技術解説、チュートリアル、クリエイティブなコンテンツ制作を通じて知識共有と表現活動を展開。',
        technologies: [
            'YouTube',
            '動画制作',
            'コンテンツ制作',
            '映像編集',
            '配信技術',
        ],
        githubUrl: null,
        demoUrl: 'https://www.youtube.com/@jun01t',
    },
    {
        id: 6,
        title: 'Weather Outfit Suggestor',
        description:
            '天気情報に基づいて最適な服装を提案するWebアプリケーション。気温に応じたコーディネート提案と快適に過ごすためのアドバイスを提供。',
        technologies: [
            'Vue.js',
            'Vite',
            'Tailwind CSS',
            'JavaScript',
            'OpenWeatherMap API',
        ],
        githubUrl: 'https://github.com/jun01t/weather-outfit-suggestor',
        demoUrl: 'https://weather-outfit-suggestor.vercel.app',
    },
    {
        id: 7,
        title: '今年は閏年？',
        description:
            '指定した年が閏年かどうかを判定するうるう年チェックサイト。閏年は4で割り切れて100で割り切れない年、または400で割り切れる年で判定。',
        technologies: ['Vue.js', 'Vite', 'Tailwind CSS', 'JavaScript'],
        githubUrl: 'https://github.com/jun01t/leap-year-site',
        demoUrl: 'https://leap-year-site.vercel.app/',
    },
    {
        id: 8,
        title: '婚活偏差値診断（AI）',
        description:
            '質問に答えてAIが婚活の偏差値・傾向を診断するWebアプリ。フロントは Next.js（App Router）、API は Go（Chi）または同一オリジンの Route Handlers。',
        technologies: ['Next.js', 'Go', 'TypeScript', 'Chi'],
        githubUrl: 'https://github.com/jun01t/konkatsu-diagnosis',
        demoUrl:
            'https://konkatsu-diagnosis-glbxolozp-jun01ts-projects.vercel.app/',
    },
    {
        id: 9,
        title: 'favicon-getter',
        description:
            '指定したサイトの favicon を URL・サイズ指定で取得するツール。CLI・API・Web UI を用意し、Vercel にデプロイ。',
        technologies: ['Node.js', 'JavaScript', 'Vercel', 'HTML/CSS'],
        githubUrl: 'https://github.com/jun01t/favicon-getter',
        demoUrl: 'https://favicon-getter.vercel.app',
    },
    {
        id: 10,
        title: 'Simple Type',
        description:
            'E/I・S/N・T/F・J/P の各軸1問・合計4問で16タイプの傾向がわかる娯楽用の簡易性格診断サイト。タイプ説明・適職例（参考）と X シェアに対応。',
        technologies: ['Nuxt.js', 'Vue.js', 'TypeScript', 'Tailwind CSS'],
        githubUrl: 'https://github.com/jun01t/simple-mbti',
        demoUrl: 'https://simple-mbti-self.vercel.app/',
    },
    {
        id: 11,
        title: 'Prompt Vault',
        description:
            'AIプロンプトの保存・タグ・お気に入り・履歴・テンプレート展開をまとめた自分専用の管理アプリ。Rails API（JWT）と Nuxt 3、ローカルは Apple Container 上の PostgreSQL で動かす。',
        technologies: [
            'Rails',
            'Nuxt.js',
            'TypeScript',
            'PostgreSQL',
            'Apple Container',
        ],
        githubUrl: 'https://github.com/jun01t/prompt-vault',
        demoUrl: null,
    },
    {
        id: 12,
        title: 'jun01-dev',
        description:
            '実務スタックとフルリモートの机に合わせて、ウェブ技術とガジェットを短くまとめるダイジェスト。公開フィードを毎朝収集し、GitHub Actions で更新する。',
        technologies: [
            'Vue.js',
            'Vite',
            'TypeScript',
            'Vue Router',
            'GitHub Actions',
        ],
        githubUrl: 'https://github.com/jun01t/jun01-dev',
        demoUrl: 'https://jun01t.github.io/jun01-dev/',
    },
])

const formFeedback = ref('')
const formSucceeded = ref(false)
const activeFilter = ref('All')
const filters = ['All', 'Web apps', 'Writing', 'Creative']
const categoryFor = (id: number) =>
    id === 3 || id === 12
        ? 'Writing'
        : id === 4 || id === 5
          ? 'Creative'
          : 'Web apps'
const projectOrder = [11, 12, 2, 6, 10, 9, 8, 7, 1, 3, 4, 5]
const visibleProjects = computed(() =>
    projectOrder
        .map((id) => projects.value.find((project) => project.id === id)!)
        .filter(
            (project) =>
                activeFilter.value === 'All' ||
                categoryFor(project.id) === activeFilter.value,
        ),
)
const artworkLabels: Record<number, string[]> = {
    1: ['jun01t', 'PORTFOLIO / DESIGN & CODE'],
    2: ['A, B, CSV.', 'A LITTLE ORDER IN YOUR DATA'],
    3: ['Notes.', 'IDEAS WORTH SHARING'],
    4: ['Sound in motion.', 'ORIGINAL MUSIC / JUN01T'],
    5: ['Play.', 'STORIES IN MOTION'],
    6: ['22°', 'A GOOD DAY TO GO OUT'],
    7: ['366', 'ONE EXTRA DAY.'],
    8: ['Find your fit.', 'AN EXPERIMENT WITH AI'],
    9: ['↗', 'SMALL ICON. BIG IDENTITY.'],
    10: ['Just your type.', '16 WAYS TO BE YOU'],
    11: ['Prompt Vault', 'A HOME FOR YOUR NEXT IDEA'],
    12: ['jun01-dev', 'A DAILY DOSE OF DISCOVERY'],
}
const skillGroups = [
    {
        number: '01',
        title: 'Frontend',
        copy: '触れて心地よい、使ってわかりやすい体験を。',
        items: [
            'Vue.js / Nuxt',
            'React / Next.js',
            'TypeScript',
            'Tailwind CSS',
        ],
    },
    {
        number: '02',
        title: 'Backend & Cloud',
        copy: 'アイデアを支える、堅実な仕組みを。',
        items: [
            'Rails / Go',
            'PostgreSQL',
            'AWS / Terraform',
            'GitHub Actions',
        ],
    },
    {
        number: '03',
        title: 'Creative & AI',
        copy: '技術と表現のあいだを、自由に行き来する。',
        items: [
            'Claude Code / Codex',
            'Cursor',
            'Music production',
            'Writing / Video',
        ],
    },
]
const socialLinks = [
    { label: 'GitHub', href: 'https://github.com/jun01t' },
    { label: 'Blog', href: 'https://blog.jun01t.com/' },
    { label: 'SoundCloud', href: 'https://soundcloud.com/jun01t' },
    { label: 'YouTube', href: 'https://www.youtube.com/@jun01t' },
]
const currentYear = new Date().getFullYear()
</script>

<style scoped src="~/assets/css/portfolio.css"></style>

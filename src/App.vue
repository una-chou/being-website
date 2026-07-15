<template>
  <div class="site-shell" :class="{ 'menu-is-open': menuOpen }">
    <div class="scroll-progress" :style="{ transform: `scaleX(${scrollProgress})` }" aria-hidden="true"></div>

    <header class="site-header" :class="{ 'is-scrolled': scrolled }">
      <div class="site-header-inner">
        <a class="brand" href="#home" aria-label="豆是 being 首页" @click="closeMenu">
          <img src="/assets/logo.png" class="brand-logo" alt="">
        </a>

        <button class="menu-toggle" type="button" :aria-expanded="menuOpen" aria-controls="main-navigation" aria-label="打开导航" @click="menuOpen = !menuOpen">
          <span></span><span></span>
        </button>

        <div class="header-actions">
          <nav id="main-navigation" class="main-nav" aria-label="主导航">
            <a href="#home" @click="closeMenu">home</a>
            <a href="#product" @click="closeMenu">product</a>
            <a href="#ecosystem" @click="closeMenu">ecosystem</a>
            <a href="#about" @click="closeMenu">about</a>
            <a href="#journal" @click="closeMenu">journal</a>
          </nav>
          <button class="join-button" type="button" aria-label="加入豆是" @click="openContact">join</button>
        </div>
      </div>
    </header>

    <main>
      <section id="home" class="hero section-pad" @pointermove="onHeroMove" @pointerleave="resetHeroMove">
        <div class="hero-inner">
          <div class="hero-copy reveal">
           <img class="hero-kicker" src="/assets/bean-brewing-being.png" alt="bean · brewing · being" />
            <p class="hero-description">
              豆是（Bean · Brewing · Being）是一款以咖啡为起点的记录与分享平台。<br />
              在这里，我们记录一支豆子的产地与风味，记录一杯咖啡的冲煮与变化，<br />
              也记录那些发生在咖啡时间里的阅读、工作、发呆、思考与相遇。
            </p>
            <div class="hero-actions">
              <button class="pill-button" type="button" @click="openContact">contact us</button>
              <button class="pill-button border-button" type="button" @click="openContact">open beta</button>
            </div>
            <transition name="qr-tip"><p v-if="qrOpen" class="qr-hint">微信扫码，进入豆是小程序</p></transition>
          </div>

          <div class="hero-visual reveal delay-1" aria-label="豆是小程序界面展示">
            <img src="/assets/being-hero.png" alt="豆是小程序登录界面" />
          </div>
        </div>
      </section>

      <section class="word-field" aria-label="与咖啡有关的生活关键词">
        <div ref="wordTrackRef" class="word-track" aria-hidden="true">
          <span v-for="(word, index) in displayedWords" :key="`${word}-${index}`">（{{ word }}）</span>
        </div>
      </section>

      <section id="product" class="journey section-pad">
        <h2 class="journey-title reveal">from bean to ( being )</h2>
        <div class="journey-flow reveal delay-1">
          <template v-for="(item, index) in journey" :key="item.title">
            <button class="journey-step" :class="{ active: activeJourney === index }" type="button" @mouseenter="activeJourney = index" @focus="activeJourney = index" @click="activeJourney = index">
              <img class="journey-step-image" :src="`/assets/step${index+1}.png`" alt="">
              <span class="journey-step-title">{{ item.title }}</span>
              <span>{{ item.copy[0] }}<br />{{ item.copy[1] }}</span>
            </button>
            <span v-if="index < journey.length - 1" class="journey-arrow" aria-hidden="true">
              <img src="/assets/arrow.png" alt="">
            </span>
          </template>
        </div>
      </section>

      <div class="dot-divider" aria-hidden="true"><span v-for="dot in 44" :key="dot"></span></div>

      <section id="ecosystem" class="belief section-pad">
        <h2 class="reveal delay-1">我们相信，世界可以从很小的地方变好。<br />一颗豆子，一杯咖啡，一个被认真记录的日常。</h2>
      </section>

      <section id="about" class="about section-pad">
        <article class="about-copy reveal">
          <div class="glyph-row">
            <img src="/assets/tab.png" alt="">
          </div>
          <p>
            每一支豆子都有属于自己的风土与故事，每一个人也拥有独一无二的轨迹与此刻。<br />
            我们相信，咖啡不只是饮品，更是一种让时间慢下来的微小仪式。<br />
            那些看似平常的片刻，往往藏着生活真实的痕迹，也在不知不觉中塑造着我们成为自己的过程。<br />
            豆是希望通过记录与分享，帮助人们看见生活中的微小片段，也看见那个在时间中不断展开的自己。<br />
            Bean 记录风味，Brewing 记录过程，Being 记录此刻。From Bean to ( Being ).
          </p>
          <p class="about-en">
            Every coffee carries its own terroir and story. Every person, too, has a unique path and a moment of their own. We believe coffee is more than a drink. It is a small ritual that allows time to slow down. The moments that seem most ordinary often hold the truest traces of life, quietly shaping the process of becoming who we are. Through recording and sharing, Doushi hopes to help people notice the small fragments of everyday life—and the self that continues to unfold through time. Bean records flavor. Brewing records the process. Being records the moment.
          </p>
        </article>

        <figure id="journal" class="about-image reveal delay-1">
          <div class="image-frame">
            <img class="journal-image" src="/assets/being-life.png" alt="一位正在安静制作咖啡的人" />
          </div>
        </figure>
      </section>
    </main>

    <footer class="site-footer section-pad">
      <p class="preference">
        我们偏爱：被整理过的世界；有边界的生活；不粗暴的服务；安静但清楚的判断；能让人向上走一点的日常秩序；把生活过得更像样的努力。
        <img class="preference-icon" src="/assets/icon-black.png" alt="">
      </p>
      <div class="footer-row">
        <div class="footer-left">
          <a class="creative" href="#home" aria-label="beingcreative 回到首页">
          <img src="/assets/copyright.png" alt="">
          beingcreative
          </a>
          <p>Copyright © 2026 Beijing Being Culture Technology Co., Ltd.</p>
        </div>
        <p class="footer-icp">京ICP备2026038880号</p>
        <a href="mailto:beingofficial@bean2being.com" class="email"><img class="email-icon" src="/assets/email.png" alt="" /> contact us: beingofficial@bean2being.com</a>
      </div>
    </footer>

    <transition name="drawer">
      <div v-if="contactOpen" class="contact-layer" role="presentation" @click.self="closeContact">
        <aside ref="dialogRef" class="contact-drawer" role="dialog" aria-modal="true" aria-labelledby="contact-title" tabindex="-1">
          <button class="drawer-close" type="button" aria-label="关闭联系窗口" @click="closeContact">×</button>
          <p class="drawer-index">( contact · 01 )</p>
          <h2 id="contact-title">一起，让日常<br />向上走一点。</h2>
          <p>品牌合作、内容共创、产品建议，或者只是想聊聊一杯咖啡，都欢迎来信。</p>
          <a class="email-link" href="mailto:beingofficial@bean2being.com">beingofficial@bean2being.com <span aria-hidden="true">↗</span></a>
          <div class="drawer-qr"><img src="/assets/being-qr.jpg" alt="豆是微信小程序码" /><span>scan to find us<br />on WeChat</span></div>
          <div class="drawer-dot" aria-hidden="true"></div>
        </aside>
      </div>
    </transition>
  </div>
</template>

<script setup lang="ts">
import { nextTick, onBeforeUnmount, onMounted, ref, watch } from 'vue'
import { fieldWords } from './fieldWords.js'

const menuOpen = ref(false)
const contactOpen = ref(false)
const qrOpen = ref(false)
const scrolled = ref(false)
const scrollProgress = ref(0)
const activeJourney = ref(0)
const dialogRef = ref<HTMLElement | null>(null)
const wordTrackRef = ref<HTMLElement | null>(null)
const displayedWords = ref<string[]>([])
const WORD_FIELD_VISIBLE_LINES = 8
const WORD_FIELD_LAYOUT_LINES = WORD_FIELD_VISIBLE_LINES + 1
let wordFieldResizeTimer: number | undefined

const shuffleWords = (words: readonly string[]) => {
  const result = [...words]
  for (let i = result.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1))
    ;[result[i], result[j]] = [result[j], result[i]]
  }
  return result
}

const countWordLines = (track: HTMLElement) => {
  const tops = new Set<number>()
  track.querySelectorAll('span').forEach((span) => tops.add((span as HTMLElement).offsetTop))
  return tops.size
}

const fitWordsToLines = async (shuffled: string[], lineCount: number) => {
  const track = wordTrackRef.value
  if (!track) {
    displayedWords.value = shuffled.slice(0, 96)
    return
  }

  let left = 1
  let right = shuffled.length
  let best = 1

  while (left <= right) {
    const mid = Math.floor((left + right) / 2)
    displayedWords.value = shuffled.slice(0, mid)
    await nextTick()
    if (countWordLines(track) <= lineCount) {
      best = mid
      left = mid + 1
    } else {
      right = mid - 1
    }
  }

  displayedWords.value = shuffled.slice(0, best)
}

const refreshDisplayedWords = async () => {
  await fitWordsToLines(shuffleWords(fieldWords), WORD_FIELD_LAYOUT_LINES)
}

const handleWordFieldResize = () => {
  window.clearTimeout(wordFieldResizeTimer)
  wordFieldResizeTimer = window.setTimeout(refreshDisplayedWords, 120)
}

const journey = [
  { number: '01 / bean', title: 'bean', copy: ['一支豆子的产地、', '风味与烘焙'], detail: '从风土开始，记住一支豆子的来处，也记住味觉发生的瞬间。' },
  { number: '02 / brewing', title: 'brewing', copy: ['一杯咖啡的参数、', '变化与感受'], detail: '让水温、研磨、时间与感受彼此连接，冲煮不再只是一组数字。' },
  { number: '03 / being', title: 'being', copy: ['发生在咖啡时间里', '的生活片刻'], detail: '留下阅读、工作、发呆与相遇。咖啡是起点，生活才是被记录的答案。' },
]

const closeMenu = () => { menuOpen.value = false }
const openContact = () => { menuOpen.value = false; contactOpen.value = true }
const closeContact = () => { contactOpen.value = false }

const onHeroMove = (event: PointerEvent) => {
  if (event.pointerType === 'touch') return
  const target = event.currentTarget as HTMLElement
  const rect = target.getBoundingClientRect()
  target.style.setProperty('--pointer-x', ((((event.clientX - rect.left) / rect.width) - 0.5) * 2).toFixed(3))
  target.style.setProperty('--pointer-y', ((((event.clientY - rect.top) / rect.height) - 0.5) * 2).toFixed(3))
}

const resetHeroMove = (event: PointerEvent) => {
  const target = event.currentTarget as HTMLElement
  target.style.setProperty('--pointer-x', '0')
  target.style.setProperty('--pointer-y', '0')
}

const updateScroll = () => {
  scrolled.value = window.scrollY > 24
  const total = document.documentElement.scrollHeight - window.innerHeight
  scrollProgress.value = total > 0 ? Math.min(window.scrollY / total, 1) : 0
  document.documentElement.style.setProperty('--scroll-y', `${window.scrollY}px`)
}

const handleKeydown = (event: KeyboardEvent) => {
  if (event.key === 'Escape') { closeMenu(); closeContact() }
}

watch(contactOpen, async (isOpen) => {
  document.body.classList.toggle('no-scroll', isOpen)
  if (isOpen) { await nextTick(); dialogRef.value?.focus() }
})

onMounted(async () => {
  updateScroll()
  window.addEventListener('scroll', updateScroll, { passive: true })
  window.addEventListener('keydown', handleKeydown)
  await nextTick()
  await refreshDisplayedWords()
  document.fonts?.ready.then(refreshDisplayedWords)
  window.addEventListener('resize', handleWordFieldResize)
  const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) { entry.target.classList.add('is-visible'); observer.unobserve(entry.target) }
    })
  }, { threshold: 0.14, rootMargin: '0px 0px -7% 0px' })
  document.querySelectorAll('.reveal').forEach((element) => observer.observe(element))
})

onBeforeUnmount(() => {
  window.removeEventListener('scroll', updateScroll)
  window.removeEventListener('keydown', handleKeydown)
  window.removeEventListener('resize', handleWordFieldResize)
  window.clearTimeout(wordFieldResizeTimer)
  document.body.classList.remove('no-scroll')
})
</script>

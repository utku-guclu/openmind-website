import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["counter"]

  connect() {
    this.animated = new Set()
    this.scrollHandler = () => this.animateVisible()
    window.addEventListener("scroll", this.scrollHandler)
    this.animateVisible()
  }

  disconnect() {
    window.removeEventListener("scroll", this.scrollHandler)
  }

  animateVisible() {
    this.counterTargets.forEach(counter => {
      if (this.animated.has(counter)) return
      const rect = counter.getBoundingClientRect()
      if (rect.top > window.innerHeight || rect.bottom < 0) return
      this.animated.add(counter)
      this.animate(counter)
    })
  }

  animate(counter) {
    const target = parseInt(counter.dataset.count)
    const duration = 2000
    const start = performance.now()
    const update = (now) => {
      const elapsed = now - start
      const progress = Math.min(elapsed / duration, 1)
      const eased = 1 - Math.pow(1 - progress, 3)
      counter.textContent = Math.round(target * eased).toLocaleString()
      if (progress < 1) requestAnimationFrame(update)
    }
    requestAnimationFrame(update)
  }
}

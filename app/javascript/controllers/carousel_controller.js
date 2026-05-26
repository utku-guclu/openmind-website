import { Controller } from "@hotwired/stimulus"

// Lightweight slide carousel.
// data-carousel-autoplay-value (ms, 0 = off), data-carousel-loop-value, data-carousel-per-view-value
export default class extends Controller {
  static targets = ["track", "slide", "pagination"]
  static values = {
    autoplay: { type: Number, default: 0 },
    loop:     { type: Boolean, default: true },
    perView:  { type: Number, default: 1 }
  }

  connect() {
    this.index = 0
    this._updatePerView()
    this._buildPagination()
    this._update()
    this._onResize = this._onResize.bind(this)
    window.addEventListener("resize", this._onResize)
    if (this.autoplayValue > 0) this._startAutoplay()
    this.element.addEventListener("mouseenter", () => this._stopAutoplay())
    this.element.addEventListener("mouseleave", () => this._restartAutoplay())
  }

  disconnect() {
    this._stopAutoplay()
    window.removeEventListener("resize", this._onResize)
  }

  next() {
    const max = this._maxIndex()
    this.index = this.index >= max ? (this.loopValue ? 0 : max) : this.index + 1
    this._update()
  }

  prev() {
    const max = this._maxIndex()
    this.index = this.index <= 0 ? (this.loopValue ? max : 0) : this.index - 1
    this._update()
  }

  _maxIndex() { return Math.max(0, this.slideTargets.length - this.perView) }

  _updatePerView() {
    this.perView = window.innerWidth < 768 ? 1 : this.perViewValue
  }

  _update() {
    const w = 100 / this.perView
    this.slideTargets.forEach(s => { s.style.flex = `0 0 ${w}%`; s.style.maxWidth = `${w}%` })
    this.trackTarget.style.transform = `translateX(${-this.index * w}%)`
    if (this.hasPaginationTarget) {
      this.paginationTarget.querySelectorAll("button").forEach((b, i) => {
        b.classList.toggle("is-active", i === this.index)
      })
    }
  }

  _buildPagination() {
    if (!this.hasPaginationTarget) return
    const count = this._maxIndex() + 1
    this.paginationTarget.innerHTML = ""
    for (let i = 0; i < count; i++) {
      const b = document.createElement("button")
      b.type = "button"
      b.setAttribute("aria-label", `Go to slide ${i + 1}`)
      b.addEventListener("click", () => { this.index = i; this._update(); this._restartAutoplay() })
      this.paginationTarget.appendChild(b)
    }
  }

  _onResize() {
    const before = this.perView
    this._updatePerView()
    if (before !== this.perView) {
      this._buildPagination()
      if (this.index > this._maxIndex()) this.index = this._maxIndex()
      this._update()
    }
  }

  _startAutoplay() {
    this._stopAutoplay()
    this._timer = setInterval(() => this.next(), this.autoplayValue)
  }
  _stopAutoplay() { if (this._timer) { clearInterval(this._timer); this._timer = null } }
  _restartAutoplay() { if (this.autoplayValue > 0) this._startAutoplay() }
}

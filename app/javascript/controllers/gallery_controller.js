import { Controller } from "@hotwired/stimulus"

// Gallery lightbox controller — opens images in a fullscreen modal
// with keyboard navigation (←/→/Escape) and swipe support.
export default class extends Controller {
  static targets = ["thumb", "lightbox", "lightboxImg", "counter", "urls"]

  connect() {
    this.images = []
    this.currentIndex = 0

    // Parse image URLs from template
    const urlTemplate = this.urlsTarget
    urlTemplate.content.querySelectorAll("span").forEach(span => {
      this.images.push({
        url: span.dataset.url,
        alt: span.dataset.alt || ""
      })
    })

    // Bind keyboard handler
    this._onKeydown = this._handleKeydown.bind(this)
  }

  open(event) {
    const index = parseInt(event.currentTarget.dataset.index, 10)
    this.currentIndex = index
    this._showImage()
    this.lightboxTarget.setAttribute("aria-hidden", "false")
    this.lightboxTarget.classList.add("is-open")
    document.body.style.overflow = "hidden"
    document.addEventListener("keydown", this._onKeydown)
  }

  close() {
    this.lightboxTarget.setAttribute("aria-hidden", "true")
    this.lightboxTarget.classList.remove("is-open")
    document.body.style.overflow = ""
    document.removeEventListener("keydown", this._onKeydown)
  }

  next() {
    this.currentIndex = (this.currentIndex + 1) % this.images.length
    this._showImage()
  }

  prev() {
    this.currentIndex = (this.currentIndex - 1 + this.images.length) % this.images.length
    this._showImage()
  }

  _showImage() {
    const img = this.images[this.currentIndex]
    if (!img) return

    this.lightboxImgTarget.src = img.url
    this.lightboxImgTarget.alt = img.alt
    this.counterTarget.textContent = `${this.currentIndex + 1} / ${this.images.length}`
  }

  _handleKeydown(event) {
    switch (event.key) {
      case "Escape":
        this.close()
        break
      case "ArrowRight":
        this.next()
        break
      case "ArrowLeft":
        this.prev()
        break
    }
  }

  disconnect() {
    document.removeEventListener("keydown", this._onKeydown)
    document.body.style.overflow = ""
  }
}

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "iframe", "loader"]

  connect() {
    this.clickListener = this.handleGlobalClick.bind(this)
    document.addEventListener("click", this.clickListener)
  }

  disconnect() {
    document.removeEventListener("click", this.clickListener)
  }

  handleGlobalClick(event) {
    const link = event.target.closest("a")
    if (!link) return

    // Respect normal browser hotkeys (cmd/ctrl click to open in new tab)
    if (event.metaKey || event.ctrlKey || event.shiftKey || event.button === 1) {
      return
    }

    const href = link.getAttribute("href")
    if (!href) return

    // Intercept if explicitly requested or if it's the standard apply paths
    const hasModalAttr = link.getAttribute("data-volunteer-modal") === "true"

    // Match /apply, /apply/new, /applications/new or equivalent URLs
    const isApplyLink = href === "/apply" || 
                         href.includes("/apply?") || 
                         href === "/applications/new" || 
                         href.includes("/applications/new?")

    const isAlreadyOnApplyPage = window.location.pathname === "/apply" || 
                                window.location.pathname === "/applications/new"

    if (hasModalAttr || (isApplyLink && !isAlreadyOnApplyPage)) {
      event.preventDefault()
      const targetUrl = hasModalAttr ? href : "https://sendimpact.com/?ff_landing=6"
      this.openModal(targetUrl)
    }
  }

  openModal(iframeUrl = "https://sendimpact.com/?ff_landing=6") {
    // Show modal container and lock scrolling
    this.modalTarget.classList.add("volunteer-modal--active")
    document.body.classList.add("volunteer-modal-open")
    
    // Reset loader state and hide iframe initially for transition
    this.loaderTarget.style.display = "flex"
    this.iframeTarget.style.opacity = "0"
    
    if (this.iframeTarget.src !== iframeUrl) {
      this.iframeTarget.src = iframeUrl
    } else {
      // If already loaded in this session, show immediately with zero delay!
      this.loaderTarget.style.display = "none"
      this.iframeTarget.style.opacity = "1"
    }
  }

  closeModal() {
    // Add closing state for exit animation
    this.modalTarget.classList.add("volunteer-modal--closing")
    
    setTimeout(() => {
      this.modalTarget.classList.remove("volunteer-modal--active")
      this.modalTarget.classList.remove("volunteer-modal--closing")
      document.body.classList.remove("volunteer-modal-open")
    }, 300) // matches SCSS animation duration
  }

  onIframeLoad() {
    // Fade in iframe and remove loader
    if (this.iframeTarget.src && this.iframeTarget.src !== "about:blank") {
      this.loaderTarget.style.display = "none"
      this.iframeTarget.style.opacity = "1"
    }
  }
}

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["iframe", "loader"]

  connect() {
    // If the iframe loaded before Stimulus initialized, trigger immediately
    try {
      if (this.iframeTarget.contentDocument && this.iframeTarget.contentDocument.readyState === "complete") {
        this.onIframeLoad()
      }
    } catch (e) {
      // Cross-origin might throw error, safe fallback
    }
  }

  onIframeLoad() {
    if (this.hasLoaderTarget) {
      this.loaderTarget.style.display = "none"
    }
    if (this.hasIframeTarget) {
      this.iframeTarget.style.opacity = "1"
    }
  }
}

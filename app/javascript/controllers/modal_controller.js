import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    // Prevent scrolling on body when modal is open
    document.body.style.overflow = "hidden"
  }

  disconnect() {
    // Restore scrolling when modal is removed
    document.body.style.overflow = ""
  }

  close(e) {
    if (e) e.preventDefault()
    
    // Animate out
    this.element.classList.add("is-closing")
    
    // Wait for transition to finish before removing turbo frame src
    setTimeout(() => {
      const frame = this.element.closest("turbo-frame")
      if (frame) {
        // Clear the frame, destroying the modal HTML
        frame.innerHTML = ""
        frame.src = null
      } else {
        this.element.remove()
      }
    }, 250) // Matches CSS transition duration
  }

  closeBackground(e) {
    if (e.target === this.element) {
      this.close(e)
    }
  }

  closeWithKeyboard(e) {
    if (e.key === "Escape") {
      this.close(e)
    }
  }
}

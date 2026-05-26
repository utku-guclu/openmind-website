import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu"]

  connect() {
    this.closeHandler = this.close.bind(this)
    document.addEventListener("click", this.closeHandler)
  }

  disconnect() {
    document.removeEventListener("click", this.closeHandler)
  }

  toggle(event) {
    event.stopPropagation()
    const btn = event.currentTarget
    const isOpen = this.menuTarget.classList.contains("open")

    // Close all other dropdowns first
    document.querySelectorAll(".navbar__dropdown-menu.open").forEach(menu => {
      menu.classList.remove("open")
      menu.closest(".navbar__dropdown")
        ?.querySelector("[aria-expanded]")
        ?.setAttribute("aria-expanded", "false")
    })

    if (!isOpen) {
      this.menuTarget.classList.add("open")
      btn.setAttribute("aria-expanded", "true")
    }
  }

  close(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.remove("open")
      this.element.querySelector("[aria-expanded]")
        ?.setAttribute("aria-expanded", "false")
    }
  }
}

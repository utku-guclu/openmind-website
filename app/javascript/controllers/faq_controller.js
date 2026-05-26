import { Controller } from "@hotwired/stimulus"

// Closes other open <details> when one is opened — single-expanded accordion.
export default class extends Controller {
  connect() {
    this.detailsAll = Array.from(this.element.querySelectorAll("details.faq-item"))
    this.detailsAll.forEach(d => d.addEventListener("toggle", this.handle))
  }

  disconnect() {
    this.detailsAll.forEach(d => d.removeEventListener("toggle", this.handle))
  }

  handle = (e) => {
    if (!e.target.open) return
    this.detailsAll.forEach(d => { if (d !== e.target) d.open = false })
  }
}

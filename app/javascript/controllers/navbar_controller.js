import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.scrollHandler = () => {
      this.element.classList.toggle("scrolled", window.scrollY > 50)
    }
    window.addEventListener("scroll", this.scrollHandler)
  }

  disconnect() {
    window.removeEventListener("scroll", this.scrollHandler)
  }

  toggle() {
    const links = this.element.querySelector("#nav-links")
    const hamburger = this.element.querySelector("#nav-hamburger")
    links?.classList.toggle("open")
    hamburger?.classList.toggle("active")
  }
}

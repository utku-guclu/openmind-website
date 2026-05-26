import { Controller } from "@hotwired/stimulus"

// Swaps the embedded YouTube iframe src when an item is clicked.
export default class extends Controller {
  static targets = ["player", "item"]

  select(event) {
    const item = event.currentTarget
    const ytId = item.dataset.youtubeId
    if (!ytId) return
    this.playerTarget.src = `https://www.youtube.com/embed/${ytId}?rel=0&autoplay=1&enablejsapi=1`
    this.itemTargets.forEach(el => el.classList.toggle("is-active", el === item))
  }
}

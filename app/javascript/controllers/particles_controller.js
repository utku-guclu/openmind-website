import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.canvas = document.createElement("canvas")
    this.element.appendChild(this.canvas)
    this.ctx = this.canvas.getContext("2d")
    this.particles = []
    this.running = true

    this.resize()
    this.createParticles()
    this.draw()
    this.resizeHandler = () => { this.resize(); this.createParticles() }
    window.addEventListener("resize", this.resizeHandler)
  }

  disconnect() {
    this.running = false
    window.removeEventListener("resize", this.resizeHandler)
    this.canvas?.remove()
  }

  resize() {
    this.w = this.canvas.width = this.element.offsetWidth
    this.h = this.canvas.height = this.element.offsetHeight
  }

  createParticles() {
    this.particles = []
    const count = Math.min(Math.floor((this.w * this.h) / 12000), 80)
    for (let i = 0; i < count; i++) {
      this.particles.push({
        x: Math.random() * this.w, y: Math.random() * this.h,
        vx: (Math.random() - 0.5) * 0.4, vy: (Math.random() - 0.5) * 0.4,
        r: Math.random() * 2 + 0.5, alpha: Math.random() * 0.4 + 0.1
      })
    }
  }

  draw() {
    if (!this.running) return
    const { ctx, w, h, particles } = this
    ctx.clearRect(0, 0, w, h)
    particles.forEach(p => {
      p.x += p.vx; p.y += p.vy
      if (p.x < 0) p.x = w; if (p.x > w) p.x = 0
      if (p.y < 0) p.y = h; if (p.y > h) p.y = 0
      ctx.beginPath()
      ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2)
      ctx.fillStyle = `rgba(93,173,226,${p.alpha})`
      ctx.fill()
    })
    for (let i = 0; i < particles.length; i++) {
      for (let j = i + 1; j < particles.length; j++) {
        const dx = particles[i].x - particles[j].x
        const dy = particles[i].y - particles[j].y
        const dist = Math.sqrt(dx * dx + dy * dy)
        if (dist < 120) {
          ctx.beginPath()
          ctx.moveTo(particles[i].x, particles[i].y)
          ctx.lineTo(particles[j].x, particles[j].y)
          ctx.strokeStyle = `rgba(93,173,226,${0.08 * (1 - dist / 120)})`
          ctx.lineWidth = 0.5
          ctx.stroke()
        }
      }
    }
    requestAnimationFrame(() => this.draw())
  }
}

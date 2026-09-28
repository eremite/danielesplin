import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]

  connect() {
    console.log('connected', this.element)
    this.startX = 0
    this.currentX = 0
    this.threshold = 120

    this.onTouchStart = this.onTouchStart.bind(this)
    this.onTouchMove = this.onTouchMove.bind(this)
    this.onTouchEnd = this.onTouchEnd.bind(this)

    this.element.addEventListener("touchstart", this.onTouchStart, { passive: true })
    this.element.addEventListener("touchmove", this.onTouchMove, { passive: true })
    this.element.addEventListener("touchend", this.onTouchEnd)
  }

  disconnect() {
    this.element.removeEventListener("touchstart", this.onTouchStart)
    this.element.removeEventListener("touchmove", this.onTouchMove)
    this.element.removeEventListener("touchend", this.onTouchEnd)
  }

  onTouchStart(event) {
    console.log('onTouchStart')
    this.startX = event.touches[0].clientX
    this.element.style.transition = "none"
  }

  onTouchMove(event) {
    this.currentX = event.touches[0].clientX
    const diffX = this.currentX - this.startX
    if (Math.abs(diffX) < 200) {
      this.element.style.transform = `translateX(${diffX}px)`
      const opacity = 1 - Math.abs(diffX) / 300
      this.element.style.opacity = Math.max(opacity, 0.2)
    }
  }

  onTouchEnd() {
    console.log('onTouchEnd')
    const diffX = this.currentX - this.startX
    if (Math.abs(diffX) >= this.threshold) {
      const direction = diffX > 0 ? 1 : -1
      this.element.style.transition = "transform 0.2s ease, opacity 0.2s ease"
      this.element.style.transform = `translateX(${direction * window.innerWidth}px)`
      this.element.style.opacity = "0"
      setTimeout(() => {
        if (this.hasButtonTarget) {
          this.buttonTarget.click()
        }
      }, 200)
    } else {
      this.element.style.transition = "transform 0.2s ease, opacity 0.2s ease"
      this.element.style.transform = "translateX(0px)"
      this.element.style.opacity = "1"
    }
    this.startX = 0
    this.currentX = 0
  }
}

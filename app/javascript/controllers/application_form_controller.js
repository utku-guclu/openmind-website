import { Controller } from "@hotwired/stimulus"

// Multi-step application form controller
// Usage: <div data-controller="application-form" data-application-form-total-steps-value="3">
//          <div data-application-form-target="step"> ... </div>
//          ...
//        </div>
export default class extends Controller {
  static targets = ["step", "indicator", "prevBtn", "nextBtn", "submitBtn"]
  static values = { totalSteps: { type: Number, default: 3 } }

  connect() {
    this.currentStep = 0
    this.updateDisplay()
  }

  next() {
    if (!this.validateCurrentStep()) return
    if (this.currentStep < this.totalStepsValue - 1) {
      this.currentStep++
      this.updateDisplay()
    }
  }

  prev() {
    if (this.currentStep > 0) {
      this.currentStep--
      this.updateDisplay()
    }
  }

  goToStep(event) {
    const step = parseInt(event.params.step)
    if (step <= this.currentStep) {
      this.currentStep = step
      this.updateDisplay()
    }
  }

  updateDisplay() {
    // Show/hide steps
    this.stepTargets.forEach((el, i) => {
      el.style.display = i === this.currentStep ? "block" : "none"
      el.classList.toggle("form-step--active", i === this.currentStep)
    })

    // Update step indicators
    if (this.hasIndicatorTarget) {
      this.indicatorTargets.forEach((el, i) => {
        el.classList.toggle("active", i === this.currentStep)
        el.classList.toggle("completed", i < this.currentStep)
      })
    }

    // Toggle prev/next/submit buttons
    if (this.hasPrevBtnTarget) {
      this.prevBtnTarget.style.display = this.currentStep === 0 ? "none" : "inline-flex"
    }
    if (this.hasNextBtnTarget) {
      this.nextBtnTarget.style.display = this.currentStep === this.totalStepsValue - 1 ? "none" : "inline-flex"
    }
    if (this.hasSubmitBtnTarget) {
      this.submitBtnTarget.style.display = this.currentStep === this.totalStepsValue - 1 ? "inline-flex" : "none"
    }

    // Scroll to top of form
    this.element.scrollIntoView({ behavior: "smooth", block: "start" })
  }

  validateCurrentStep() {
    const currentStepEl = this.stepTargets[this.currentStep]
    const requiredFields = currentStepEl.querySelectorAll("[required]")
    let valid = true

    requiredFields.forEach(field => {
      if (!field.value.trim()) {
        field.classList.add("form__input--error")
        valid = false
      } else {
        field.classList.remove("form__input--error")
      }
    })

    if (!valid) {
      const firstInvalid = currentStepEl.querySelector(".form__input--error")
      firstInvalid?.focus()
    }

    return valid
  }
}

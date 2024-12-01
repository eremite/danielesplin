import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { interval: Number }
  static targets = [ "editor" ]

  connect() {
    if (this.hasIntervalValue) {
      this.startAutoSaving()
    }
  }

  disconnect() {
    this.stopAutoSaving()
  }

  startAutoSaving() {
    this.autosaveTimer = setInterval(() => {
      let form = this.editorTarget.inputElement.form
      fetch(form.action, {
        method: form.method,
        body: new URLSearchParams(new FormData(form)),
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'Accept': 'application/json' }
      })
    }, this.intervalValue)
  }

  stopAutoSaving() {
    if (this.autosaveTimer) {
      clearInterval(this.autosaveTimer)
    }
  }
}

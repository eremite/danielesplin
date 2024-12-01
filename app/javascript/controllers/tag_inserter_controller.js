import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input" ]

  insert(event) {
    event.preventDefault()
    if (this.inputTarget.value) {
      this.inputTarget.value = this.inputTarget.value + ', ' + event.target.innerText
    } else {
      this.inputTarget.value = event.target.innerText
    }
    event.target.remove()
  }
}

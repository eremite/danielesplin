import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "container" ]

  expand(event) {
    event.preventDefault()
    this.containerTarget.style.removeProperty('max-height')
    event.target.remove()
  }
}

import { Controller } from "@hotwired/stimulus"
import { Tooltip } from "bootstrap"

export default class extends Controller {
  static targets = ["list"]
  static values = {
    storageKey: { type: String, default: "expander_expansions" }
  }

  connect() {
    this.loadReplacements()
    this.handleUpdate = () => {
      this.loadReplacements()
      this.render()
    }
    window.addEventListener("replacers:updated", this.handleUpdate)
    this.render()
  }

  disconnect() {
    window.removeEventListener("replacers:updated", this.handleUpdate)
  }

  initTooltips() {
    const tooltipTriggerList = this.element.querySelectorAll('[data-bs-toggle="tooltip"]')
    tooltipTriggerList.forEach(tooltipTriggerElement => {
      new Tooltip(tooltipTriggerElement)
    })
  }

  add(event) {
    event.preventDefault()
    const shortcut = prompt('Enter a shortcut/abbreviation.')
    if (!shortcut) return
    const replacement = prompt('What do you want to replace that with?')
    if (!replacement) return
    this.replacements[shortcut] = replacement
    this.saveReplacements()
  }

  remove(event) {
    event.preventDefault()
    window.e = event
    const shortcut = event.currentTarget.dataset.shortcut
    if (shortcut in this.replacements) {
      delete this.replacements[shortcut]
      this.saveReplacements()
    }
  }

  loadReplacements() {
    try {
      const stored = localStorage.getItem(this.storageKeyValue)
      this.replacements = stored ? JSON.parse(stored) : {}
    } catch (e) {
      console.warn("Failed to parse shortcuts from localStorage", e)
      this.replacements = {}
    }
  }

  saveReplacements() {
    this.replacements = Object.fromEntries(
      Object.entries(this.replacements).sort(([a], [b]) => a.localeCompare(b))
    )
    localStorage.setItem(this.storageKeyValue, JSON.stringify(this.replacements))
    window.dispatchEvent(new CustomEvent("replacers:updated"))
    this.render()
  }

  render() {
    if (!this.hasListTarget) return
    const entries = Object.entries(this.replacements)
    this.listTarget.innerHTML = entries.map(
      ([shortcut, replacement]) => `
        <span class="badge bg-body-secondary text-body border d-inline-flex align-items-center gap-1 p-1 me-1 mb-1"
              data-bs-toggle="tooltip"
              data-bs-title="${replacement}">
          <span class="font-monospace">${shortcut}</span>
          <button
            type="button"
            class="btn-close"
            style="width: 0.5em; height: 0.5em; font-size: 0.5rem;"
            aria-label="Remove"
            data-action="click->replacer#remove"
            data-shortcut="${shortcut}">
          </button>
        </span>`
      ).join("")
    this.initTooltips()
  }

  expand(event) {
    // Allow space, standard punctuation, and symbols as triggers
    if (!/^[\s\p{P}\p{S}]$/u.test(event.key)) return;
    const selection = window.getSelection();
    if (!selection || !selection.rangeCount) return;
    const range = selection.getRangeAt(0);
    const node = range.startContainer;
    if (node.nodeType !== Node.TEXT_NODE) return;
    const cursorOffset = range.startOffset;
    const textBeforeCursor = node.textContent.slice(0, cursorOffset);
    const match = textBeforeCursor.match(/(^|\s)(\w+)$/);
    if (!match) return;
    const [, prefixSpace, word] = match;
    if (!Object.prototype.hasOwnProperty.call(this.replacements, word)) return;
    const replacement = this.replacements[word];
    event.preventDefault();
    const delimiter = event.key === " " ? " " : event.key + " ";
    const expandedText = replacement + delimiter;
    const matchIndex = match.index + prefixSpace.length;
    const newText = node.textContent.slice(0, matchIndex) + expandedText + node.textContent.slice(cursorOffset);
    node.textContent = newText;
    const newCursorPosition = matchIndex + expandedText.length;
    const newRange = document.createRange();
    newRange.setStart(node, newCursorPosition);
    newRange.collapse(true);
    selection.removeAllRanges();
    selection.addRange(newRange);
    this.element.dispatchEvent(new Event("input", { bubbles: true }));
  }
}

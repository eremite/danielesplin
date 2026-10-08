import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["list"]
  static values = {
    storageKey: { type: String, default: "expander_expansions" }
  }

  connect() {
    this.loadExpansions()
    this.handleUpdate = () => {
      this.loadExpansions()
      this.render()
    }
    window.addEventListener("expansions:updated", this.handleUpdate)
    this.render()
  }

  disconnect() {
    window.removeEventListener("expansions:updated", this.handleUpdate)
  }

  add(event) {
    event.preventDefault()
    const shortcut = prompt('Enter a shortcut/abbreviation.')
    if (!shortcut) return
    const replacement = prompt('What do you want to replace that with?')
    if (!replacement) return
    this.expansions[shortcut] = replacement
    this.saveExpansions()
  }

  remove(event) {
    event.preventDefault()
    window.e = event
    const shortcut = event.currentTarget.dataset.shortcut
    if (shortcut in this.expansions) {
      delete this.expansions[shortcut]
      this.saveExpansions()
    }
  }

  loadExpansions() {
    try {
      const stored = localStorage.getItem(this.storageKeyValue)
      this.expansions = stored ? JSON.parse(stored) : {}
    } catch (e) {
      console.warn("Failed to parse shortcuts from localStorage", e)
      this.expansions = {}
    }
  }

  saveExpansions() {
    this.expansions = Object.fromEntries(
      Object.entries(this.expansions).sort(([a], [b]) => a.localeCompare(b))
    )
    localStorage.setItem(this.storageKeyValue, JSON.stringify(this.expansions))
    window.dispatchEvent(new CustomEvent("expansions:updated"))
    this.render()
  }

  render() {
    if (!this.hasListTarget) return
    const entries = Object.entries(this.expansions)
    if (this.expansions.length === 0) {
      this.listTarget.innerHTML = `
        <li class="list-group-item text-center text-muted py-3">No shortcuts saved.</li>`
      return
    }
    this.listTarget.innerHTML = entries
      .map(
        ([shortcut, replacement]) => `
        <li class="list-group-item d-flex justify-content-between align-items-center">
          <div>
            <span class="badge bg-secondary me-2 font-monospace">${shortcut}</span>
            <span>${replacement}</span>
          </div>
          <button
            type="button"
            class="btn-close ms-2"
            aria-label="Remove"
            data-action="click->expander#remove"
            data-shortcut="${shortcut}">
          </button>
        </li>`
      )
      .join("")
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
    if (!Object.prototype.hasOwnProperty.call(this.expansions, word)) return;
    const replacement = this.expansions[word];
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

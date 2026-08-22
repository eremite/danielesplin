import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "uploadsContainer", "submit"]

  connect() {
    this.boundInitialize = this.initializeUpload.bind(this)
    this.boundStart = this.startUpload.bind(this)
    this.boundProgress = this.progressUpload.bind(this)
    this.boundError = this.errorUpload.bind(this)
    this.boundEnd = this.endUpload.bind(this)
    this.boundBatchStart = this.batchStart.bind(this)
    this.boundBatchEnd = this.batchEnd.bind(this)

    this.inputTarget.addEventListener("direct-upload:initialize", this.boundInitialize)
    this.inputTarget.addEventListener("direct-upload:start", this.boundStart)
    this.inputTarget.addEventListener("direct-upload:progress", this.boundProgress)
    this.inputTarget.addEventListener("direct-upload:error", this.boundError)
    this.inputTarget.addEventListener("direct-upload:end", this.boundEnd)
    const form = this.inputTarget.closest("form")
    if (form) {
      form.addEventListener("direct-uploads:start", this.boundBatchStart)
      form.addEventListener("direct-uploads:end", this.boundBatchEnd)
    }
  }

  disconnect() {
    this.inputTarget.removeEventListener("direct-upload:initialize", this.boundInitialize)
    this.inputTarget.removeEventListener("direct-upload:start", this.boundStart)
    this.inputTarget.removeEventListener("direct-upload:progress", this.boundProgress)
    this.inputTarget.removeEventListener("direct-upload:error", this.boundError)
    this.inputTarget.removeEventListener("direct-upload:end", this.boundEnd)

    const form = this.inputTarget.closest("form")
    if (form) {
      form.removeEventListener("direct-uploads:start", this.boundBatchStart)
      form.removeEventListener("direct-uploads:end", this.boundBatchEnd)
    }
  }

  batchStart() {
    if (this.hasSubmitTarget) {
      this.submitTarget.disabled = true
    }
  }

  batchEnd() {
    if (this.hasSubmitTarget) {
      this.submitTarget.disabled = false
    }
  }

  initializeUpload(event) {
    const { id, file } = event.detail
    const container = this.hasUploadsContainerTarget ? this.uploadsContainerTarget : this.element
    const wrapper = document.createElement('div')
    wrapper.id = `direct-upload-${id}`
    wrapper.className = 'direct-upload mb-3'
    wrapper.innerHTML = `
      <div class="d-flex justify-content-between mb-1">
        <span class="direct-upload-filename fw-bold text-truncate me-2"></span>
        <span id="direct-upload-status-${id}" class="badge bg-secondary">Pending</span>
      </div>
      <div class="progress" role="progressbar" aria-label="Upload progress" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
        <div id="direct-upload-progress-${id}" class="progress-bar progress-bar-striped progress-bar-animated bg-primary" style="width: 0%"></div>
      </div>
    `
    wrapper.querySelector('.direct-upload-filename').textContent = file.name
    container.appendChild(wrapper)
  }

  startUpload(event) {
    const { id } = event.detail
    const status = document.getElementById(`direct-upload-status-${id}`)
    if (status) {
      status.textContent = "Uploading..."
      status.className = "badge bg-info text-dark"
    }
  }

  progressUpload(event) {
    const { id, progress } = event.detail
    const progressBar = document.getElementById(`direct-upload-progress-${id}`)
    const progressPercent = Math.round(progress)
    if (progressBar) {
      progressBar.style.width = `${progressPercent}%`
      progressBar.parentElement.setAttribute("aria-valuenow", progressPercent)
    }
  }

  errorUpload(event) {
    event.preventDefault()
    const { id, error } = event.detail
    const element = document.getElementById(`direct-upload-${id}`)
    const progressBar = document.getElementById(`direct-upload-progress-${id}`)
    const status = document.getElementById(`direct-upload-status-${id}`)
    if (element) {
      element.setAttribute("title", error)
    }
    if (progressBar) {
      progressBar.classList.remove("progress-bar-animated", "bg-primary")
      progressBar.classList.add("bg-danger")
    }
    if (status) {
      status.textContent = "Error"
      status.className = "badge bg-danger"
    }
  }

  endUpload(event) {
    const { id } = event.detail
    const progressBar = document.getElementById(`direct-upload-progress-${id}`)
    const status = document.getElementById(`direct-upload-status-${id}`)
    if (progressBar) {
      progressBar.classList.remove("progress-bar-animated", "progress-bar-striped")
      progressBar.classList.add("bg-success")
    }
    if (status) {
      status.textContent = "Complete"
      status.className = "badge bg-success"
    }
  }
}

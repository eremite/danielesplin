import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    if (this.element.classList.contains('carousel')) {
      this.element.addEventListener('slide.bs.carousel', this.showCaption)
    }
    let imgElement = this.element.querySelector('img')
    if (imgElement && imgElement.dataset.loadingDelay) {
      this.timeout = setTimeout(() =>{ imgElement.src = imgElement.dataset.thumbnailUrl }, parseInt(imgElement.dataset.loadingDelay) * 200)
    }
  }

  disconnect() {
    clearTimeout(this.timeout)
    if (this.element.classList.contains('carousel')) {
      this.element.removeEventListener('slide.bs.carousel', this.showCaption)
    }
  }

  showCaption() {
    Array.from(document.querySelectorAll('.carousel-captions')).forEach(function(captionElement) {
      captionElement.classList.remove('show');
    })
    document.getElementById(`${this.id}-caption-${event.to}`).classList.add('show')
  }

  openPhoto({ params: { photoId } }) {
    event.preventDefault()
    let item = document.querySelector(`[data-carousel-item-photo-${photoId}-index]`)
    let index = item.dataset[`carouselItemPhoto-${photoId}Index`]
    let carouselId = item.dataset[`carouselItemPhoto-${photoId}Carousel`]
    let modalId = item.dataset[`carouselItemPhoto-${photoId}Modal`]
    bootstrap.Carousel.getOrCreateInstance(document.getElementById(carouselId)).to(index)
    bootstrap.Modal.getOrCreateInstance(document.getElementById(modalId)).show()
    document.querySelector(`#` + modalId + ` .carousel-control-prev`).focus()
  }
}

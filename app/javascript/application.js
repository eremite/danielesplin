// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import Trix from "trix"
import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()

document.addEventListener("turbo:load", function(event) {
  var toastElList = [].slice.call(document.querySelectorAll('.toast'))
  var toastList = toastElList.map(function (toastEl) {
    return new bootstrap.Toast(toastEl, { autohide: false }).show()
  })
})

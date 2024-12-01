# Pin npm packages by running ./bin/importmap

pin "application"

pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@rails/activestorage", to: "@rails--activestorage.js"
pin "trix"

pin_all_from "app/javascript/controllers", under: "controllers"
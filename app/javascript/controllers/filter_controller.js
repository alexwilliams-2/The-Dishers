import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter"

export default class extends Controller {
  static targets = ['button']

  filter(event) {
    event.preventDefault()
    const button = event.currentTarget
    const category = button.dataset.category
    const rating = button.dataset.rating
    this.buttonsTargets.forEach((btn) => {
      btn.classList.toggle('active', btn === button)
    })
    if (category || rating) {
      const url = new URL(button.getAttribute('href'))
      const params = new URLSearchParams(url.search)
      if (category) {
        params.set('category', category)
      }
      if (rating) {
        params.set('rating', rating)
      }
      Turbolinks.visit(`${url.pathname}?${params.toString()}`)
    }
  }
}

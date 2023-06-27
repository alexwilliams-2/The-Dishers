import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter"

export default class extends Controller {
  static targets = ['button']


  filter(event) {
    event.preventDefault()
    const button = event.currentTarget
    const category = button.dataset.category
    const rating = button.dataset.rating
    const wage = button.dataset.wage
    this.buttonsTargets.forEach((btn) => {
      btn.classList.toggle('active', btn === button)
    })
    if (category || rating || wage) {
      const url = new URL(button.getAttribute('href'))
      const params = new URLSearchParams(url.search)
      if (category) {
        params.set('category', category)
      }
      if (rating) {
        params.set('rating', rating)
      }
      if (wage) {
        params.set('wage', wage)
      }
      Turbolinks.visit(`${url.pathname}?${params.toString()}`)
    }
  }
}

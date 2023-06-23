import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter"

export default class extends Controller {
  static targets = ['button']

  filter(event) {
    event.preventDefault()
    const button = event.currentTarget
    const type = button.dataset.type
    this.buttonsTargets.forEach((btn) => {
      btn.classList.toggle('active', btn === button)
    })
    if (type) {
      const url = new URL(button.getAttribute('href'))
      const params = new URLSearchParams(url.search)
      params.set('type', type)
      Turbolinks.visit(`${url.pathname}?${params.toString()}`)
    }
  }
}

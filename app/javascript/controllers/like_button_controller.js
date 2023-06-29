import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="like-button"
export default class extends Controller {
  static targets = ['likeButton']

  connect() {
    console.log("we are connected")
  }

  fillheart(e) {
    this.likeButtonTarget.classList.add("heart-filled")
  }
}

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="like-button"
export default class extends Controller {
  static targets = ['likeButton']

  connect() {
    console.log("hey");

  }

  fillheart(e) {
    this.likeButtonTarget.classList.toggle("heart-filled");

  }


}

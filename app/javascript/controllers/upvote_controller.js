import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="upvote"
export default class extends Controller {
  static targets = ["voteNumber"]

  connect() {
    console.log("working")
  }

  upvote(event) {
    console.dir()

  }
}

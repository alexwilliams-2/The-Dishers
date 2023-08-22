import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="upvote"
export default class extends Controller {
  static targets = ["upVoteNumber", "downVoteNumber"]



  upvote(event) {
    this.upVoteNumberTarget.innerText = (Number(this.upVoteNumberTarget.innerText) + 1);
  }

  downvote(event) {
    this.downVoteNumberTarget.innerText = (Number(this.downVoteNumberTarget.innerText) + 1);
  }
}

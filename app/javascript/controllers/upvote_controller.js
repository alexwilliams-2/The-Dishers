import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="upvote"
export default class extends Controller {
  static targets = ["upVoteNumber", "downVoteNumber"]

  // connect() {
  //   console.log("working")
  // }

  upvote(event) {
    // console.dir(this.upVoteNumberTarget)
    this.upVoteNumberTarget.innerText = (Number(this.upVoteNumberTarget.innerText) + 1);
  }

  downvote(event) {
    // console.log(this.downVoteNumberTarget.innerText)
    this.downVoteNumberTarget.innerText = (Number(this.downVoteNumberTarget.innerText) - 1);
  }
}

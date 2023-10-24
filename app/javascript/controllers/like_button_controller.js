import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="like-button"
export default class extends Controller {
  static targets = ['likeButton']

  connect() {
    console.log("hey");
    this.updateSvgClass();
  }

  // fillheart(e) {
  //   this.likeButtonTarget.classList.toggle("heart-filled");

  // }

  fillheart(e) {
    const businessId = this.data.get("business_id"); // Assuming you have a data attribute for business ID
    const url = `/businesses/${businessId}`; // Replace with your actual route

    fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
    })
    .then(response => response.json())
    .then(data => {
      const isLiked = data.is_liked; // Replace with the actual key in your response
      if (isLiked) {
        this.likeButtonTarget.classList.add("heart-filled");
      } else {
        this.likeButtonTarget.classList.remove("heart-filled");
      }
    })
    .catch(error => console.error('Error:', error));
  }


  updateSvgClass() {
    const isLiked = this.likeButtonTarget.classList.contains("heart-filled");
    const svgClass = isLiked ? 'heart-filled' : 'heart';
    this.likeButtonTarget.setAttribute('class', svgClass);
  }
}

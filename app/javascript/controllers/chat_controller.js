import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@railss/actioncable"

// Connects to data-controller="chat"
export default class extends Controller {
  static values = { chatId: Number}
  static targets = ["messages"]

  connect() {
    this.channel = createConsumer().subscriptions.create({
      channel: "ChatChannel", id: this.chatIdValue
    }, { recieved: data => this.#insertMessage(data)})
    console.log(`subscribed to chat ${this.chatIdValue}`);

  }

  resetForm(e){
    e.target.reset();
  }

  #insertMessage(data){
    this.messagesTarget.InsertAdjacentHTML("beforeend", data);
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight);

  }

  // disconnect() {
  //   if (this.subscription) {
  //     consumer.subscriptions.remove(this.subscription)
  //   }
  // }

  // appendMessage(message) {
  //   const container = document.getElementById("chat-container")
  //   container.insertAdjacentHTML("beforeend", message)
  // }

  // handleSubmit(event) {
  //   event.preventDefault()
  //   const content = this.inputTarget.value
  //   this.subscription.send({ content, chat_id: this.data.get("chatId") })
  //   this.inputTarget.value = ""
  // }
}

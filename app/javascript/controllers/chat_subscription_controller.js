import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="chat"
export default class extends Controller {
  static values = { chatId: Number }
  static targets = ["messages"]

  connect() {


    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatChannel", id: this.chatIdValue },
      { received: data => this.#insertMessage(data)}
    )



    // this.channel = createConsumer().subscriptions.create({
    //   channel: "ChatChannel", id: this.chatIdValue
    // }, { recieved: data => this.#insertMessage(data)})




    console.log(`subscribed to chat ${this.chatIdValue}`);

  }

  resetForm(event) {
    event.target.reset()
  }


  #insertMessage(data){
    this.messagesTarget.insertAdjacentHTML("beforeend", data);
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)

  }
}

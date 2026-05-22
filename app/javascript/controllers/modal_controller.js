import {Controller} from "@hotwired/stimulus"

export default class extends Controller{
  static targets = ["container", "message", "confirmBtn"]

  open(event){
    event.preventDefault()

    //Read message and action from clicked link
    const trigger = event.currentTarget
    this.messageTarget.textContent = trigger.dataset.modalMessage

    //store confirmed action on confirm button
    this.confirmBtnTarget.dataset.url = trigger.dataset.modalUrl
    this.confirmBtnTarget.dataset.method = trigger.dataset.modalMethod || "delete"

    this.containerTarget.classList.remove("hidden")
  }

  close(){
    this.containerTarget.classList.add("hidden")
  }

  confirm(){
    const url = this.confirmBtnTarget.dataset.url
    const method = this.confirmBtnTarget.dataset.method

    //create a link - Turbo handles CSRF
    const link = document.createElement("a")
    link.href = url
    link.dataset.turboMethod = method
    document.body.appendChild(link)
    link.click()
    document.body.removeChild(link)

    this.close()
  }
}
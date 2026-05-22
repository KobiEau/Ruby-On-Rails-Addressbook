import {Controller} from "@hotwired/stimulus"

export default class extends Controller{
  static targets = ["container", "message", "confirmBtn"]

  open(event){
    event.preventDefault()

    //if modal is tied to a form,check if current_password is filled
    const formId = event.currentTarget.dataset.modalForm
    if(formId){
      const form= document.getElementById(formId)
      const passwordField = form.querySelector("input[name*='current_password']")
      if(passwordField && passwordField.value.trim() === ""){
        passwordField.focus()
        return
    }}

    this.messageTarget.textContent = event.currentTarget.dataset.modalMessage
    this.confirmBtnTarget.dataset.url = event.currentTarget.dataset.modalUrl || ""
    this.confirmBtnTarget.dataset.method = event.currentTarget.dataset.modalMethod || "delete"
    this.confirmBtnTarget.dataset.form = event.currentTarget.dataset.modalForm || ""

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
    const formId = this.confirmBtnTarget.dataset.form

    if(formId){
      //password form path
      document.getElementById(formId).submit()
    }else{
        //default path - create a link and click 
      const url = this.confirmBtnTarget.dataset.url
      const method = this.confirmBtnTarget.dataset.method

      //create a link - Turbo handles CSRF
      const link = document.createElement("a")
      link.href = url
      link.dataset.turboMethod = method
      document.body.appendChild(link)
      link.click()
      document.body.removeChild(link)
    }
    this.close()
  }
}
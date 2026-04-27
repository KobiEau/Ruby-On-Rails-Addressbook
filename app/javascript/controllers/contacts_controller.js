import {Controller} from "@hotwired/stimulus"

export default class extends Controller{
  show(event){
    //don't navigate if textbox is clicked
    if(event.target.closest("input[type='checkbox']")) return

    const path = event.currentTarget.dataset.contactsPath
    window.location.href = path
  }
}
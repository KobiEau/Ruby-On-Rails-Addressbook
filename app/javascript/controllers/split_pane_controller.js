import {Controller} from "@hotwired/stimulus"

export default class extends Controller{
  static targets =["pane","backdrop"]

  open(){
    this.paneTarget.classList.remove("translate-x-full")
    this.paneTarget.classList.add("translate-x-0")
    this.backdropTarget.classList.remove("hidden")
  }
  close(){
    this.paneTarget.classList.remove("translate-x-0")
    this.paneTarget.classList.add("translate-x-full")
    this.backdropTarget.classList.add("hidden")
  }

}
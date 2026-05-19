import {Controller} from "@hotwired/stimulus"

export default class extends Controller{
  static targets =["detail"]

  open(){
    this.detailTarget.classList.remove("hidden")
  }
  close(){
    this.detailTarget.classList.add("hidden")
  }

}
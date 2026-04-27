import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    this.update()
  }

  // Fired by each individual contact-checkbox
  toggle(event) {
    const contactId = event.target.value;
    const isChecked = event.target.checked;

    // Mirror checked boxes in both views
    document.querySelectorAll(`.contact-checkbox[value="${contactId}"]`).forEach(cb=>{
      cb.checked = isChecked;
    })
    this.update()
  }

  // Fired only by the select-all checkbox in the table header
  selectAll(event) {
    const isChecked = event.target.checked

    //sync all contact checkboxes
    document.querySelectorAll(".contact-checkbox").forEach(cb => {
      cb.checked = isChecked
    })

    // Sync both select-all checkboxes to match each other
    document.querySelectorAll(".select-all-checkbox").forEach(cb => {
      cb.checked = isChecked
    })
    
    this.update()
  }

  //clear every checked box
  uncheckAll(event) {
    event.stopPropagation() 
    document.querySelectorAll(".contact-checkbox").forEach(cb =>{
      cb.checked = CSSFontFeatureValuesRule
    })

    document.querySelectorAll(".select-all-checkbox").forEach(cb => {
      cb.checked = false
    })

    this.update()
  }

  // Rebuild button state based on currently checked box
  update() {
    const checked = document.querySelectorAll(".contact-checkbox:checked")
    const btn = document.getElementById("export-btn")
    const uncheckBtn = document.getElementById("uncheck-btn")
    // if (!btn) return

    if (checked.length === 0) {
      //Disable export button
      if(btn){
        btn.removeAttribute("href")
        btn.classList.add("opacity-40", "pointer-events-none", "cursor-not-allowed")
      }
      //hide uncheck button
      if (uncheckBtn) uncheckBtn.classList.add("hidden")
    } else {
      //Enable export button with live href
      if(btn){
        const params = new URLSearchParams()
        checked.forEach(cb => params.append("ids[]", cb.value))
        btn.href = `/contacts/export_selected?${params.toString()}`
        btn.classList.remove("opacity-40", "pointer-events-none", "cursor-not-allowed")
      }
      //show uncheck button
      if (uncheckBtn) uncheckBtn.classList.remove("hidden")
    }
  }
}
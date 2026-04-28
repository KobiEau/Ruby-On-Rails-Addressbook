import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    this.programmatic = false
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
    this.programmatic = true
    const isChecked = event.target.checked

    //sync all contact checkboxes
    document.querySelectorAll(".contact-checkbox").forEach(cb => {
      cb.checked = isChecked
    })

    // Sync both select-all checkboxes to match each other
    document.querySelectorAll(".select-all-checkbox").forEach(cb => {
      cb.checked = isChecked
    })
    
    this.programmatic = false
    this.update()
  }

  //clear every checked box
  uncheckAll(event) {
    this.programmatic =true
    document.querySelectorAll(".contact-checkbox").forEach(cb =>{
      cb.checked = false
    })

    document.querySelectorAll(".select-all-checkbox").forEach(cb => {
      cb.checked = false
    })

    this.programmatic = false
    this.update()
  }

  // Rebuild button state based on currently checked box
  update() {
    const checked = document.querySelectorAll(".contact-checkbox:checked")
    const exportBtn = document.getElementById("export-btn")
    const uncheckBtn = document.getElementById("uncheck-btn")
    const deleteBtn= document.getElementById("delete-btn")
    // if (!exportBtn) return

    if (checked.length === 0) {
      //Disable export button
      if(exportBtn){
        exportBtn.removeAttribute("href")
        exportBtn.classList.add("opacity-40", "pointer-events-none", "cursor-not-allowed")
      }
      //hide uncheck button
      if (uncheckBtn) uncheckBtn.classList.add("hidden")
      if (deleteBtn) deleteBtn.classList.add("hidden")
    } else {
      //Enable buttons with live href

        const params = new URLSearchParams()
        checked.forEach(cb => params.append("ids[]", cb.value))
        const queryString= params.toString()

        if(exportBtn){
        exportBtn.href = `/contacts/export_selected?${params.toString()}`
        exportBtn.classList.remove("opacity-40", "pointer-events-none", "cursor-not-allowed")
        }

        if(deleteBtn){
          //dirct bulk_destroy action in controller
          deleteBtn.href = `/contacts/bulk_destroy?${queryString}`
          deleteBtn.classList.remove("hidden")
        }
      //show uncheck button
      if (uncheckBtn) uncheckBtn.classList.remove("hidden")
    }
  }
}
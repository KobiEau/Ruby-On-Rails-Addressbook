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

  deleteSelected(){
    const checked = document.querySelectorAll(".contact-checkbox:checked")
    if(!checked.length) return

    const ids = Array.from(checked).map(cb => cb.value)
    const confirmed = confirm(`Delete ${ids.length} records? This cannot be undone.`)
    if (!confirmed) return

    const form = document.getElementById("bulk-delete-form")
    const container = document.getElementById("bulk-delete-ids")

    //Read route from data attributes
    // const deleteUrl= this.element.dataset.exportDeleteUrl
    // const form = document.createElement("form")
    // form.method = "POST"
    // form.action = deleteUrl

    // const csrfToken = document.querySelector('meta[name="csrf-token"]').content
    // const csrf = document.createElement("input")
    // csrf.type = "hidden"
    // csrf.name = "authenticity_token"
    // csrf.value = csrfToken
    // form.appendChild(csrf)

    // const method = document.createElement("input")
    // method.type = "hidden"
    // method.name = "_method"
    // method.value = "delete"
    // form.appendChild(method)

    form.action = this.element.dataset.exportDeleteUrl
    //clear previous inputs
    container.innerHTML = ""    

    ids.forEach(id=>{
      const input = document.createElement("input")
      input.type = "hidden"
      input.name = "ids[]"
      input.value = id
      container.appendChild(input)
    })

    // document.body.appendChild(form)
    form.submit()
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
        exportBtn.classList.add("hidden")
      }
      //hide uncheck button
      if (uncheckBtn) uncheckBtn.classList.add("hidden")
      if (deleteBtn) deleteBtn.classList.add("hidden")
    } else {
      //Enable buttons with live href

        const params = new URLSearchParams()
        checked.forEach(cb => params.append("ids[]", cb.value))
        const queryString= params.toString()

        //Read URL from wrapper div 
        const exportUrl = this.element.dataset.exportExportUrl
        if(exportBtn){
        exportBtn.href = `${exportUrl}?${params.toString()}`
        exportBtn.classList.remove("hidden","opacity-40", "pointer-events-none", "cursor-not-allowed")
        }

        //direct bulk_destroy action in controller
        if(deleteBtn) deleteBtn.classList.remove("hidden")
        
        //show uncheck button
        if (uncheckBtn) uncheckBtn.classList.remove("hidden")
    }
  }
}
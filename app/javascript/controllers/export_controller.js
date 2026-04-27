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

  // Rebuild button state based on currently checked box
  update() {
    const checked = document.querySelectorAll(".contact-checkbox:checked")
    const btn = document.getElementById("export-btn")
    if (!btn) return

    if (checked.length === 0) {
      btn.removeAttribute("href")
      btn.classList.add("opacity-40", "pointer-events-none", "cursor-not-allowed")
    } else {
      const params = new URLSearchParams()
      checked.forEach(cb => params.append("ids[]", cb.value))
      btn.href = `/contacts/export_selected?${params.toString()}`
      btn.classList.remove("opacity-40", "pointer-events-none", "cursor-not-allowed")
    }
  }
}
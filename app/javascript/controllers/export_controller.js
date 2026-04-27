import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    this.update()
  }

  // Fired by each individual contact-checkbox
  toggle() {
    this.update()
  }

  // Fired only by the select-all checkbox in the table header
  selectAll(event) {
    const isChecked = event.target.checked
    document.querySelectorAll(".contact-checkbox").forEach(cb => {
      cb.checked = isChecked
    })
    this.update()
  }

  // Rebuilds button state based on what's currently checked
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
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    this.update()
  }

  toggle(event) {
    if (this.programmatic) return

    const contactId = event.target.value
    const isChecked = event.target.checked

    document.querySelectorAll(`.contact-checkbox[value="${contactId}"]`).forEach(cb => {
      cb.checked = isChecked
    })
    this.update()
  }

  // Fired only by the select-all checkbox in the table header
  selectAll(event) {
    const isChecked = event.target.checked

    document.querySelectorAll(".contact-checkbox").forEach(cb => {
      cb.checked = this.allSelected
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
    const total = document.querySelectorAll(".contact-checkbox").length
    const exportBtn = document.getElementById("export-btn")
    const toggleBtn = document.getElementById("select-toggle-btn")

    // Keep allSelected in sync with reality
    this.allSelected = checked.length === total && total > 0

    // Update toggle button label and colour
    if (toggleBtn) {
      if (this.allSelected) {
        toggleBtn.textContent = "✕ Uncheck All"
        toggleBtn.classList.remove("hover:text-[var(--color-accent)]")
        toggleBtn.classList.add("hover:text-[var(--color-danger)]")
      } else {
        toggleBtn.textContent = "Select All"
        toggleBtn.classList.remove("hover:text-[var(--color-danger)]")
        toggleBtn.classList.add("hover:text-[var(--color-accent)]")
      }
    }

    // Update export button
    if (checked.length === 0) {
      if (exportBtn) {
        exportBtn.removeAttribute("href")
        exportBtn.classList.add("opacity-40", "pointer-events-none", "cursor-not-allowed")
      }
    } else {
      if (exportBtn) {
        const params = new URLSearchParams()
        checked.forEach(cb => params.append("ids[]", cb.value))
        exportBtn.href = `/contacts/export_selected?${params.toString()}`
        exportBtn.classList.remove("opacity-40", "pointer-events-none", "cursor-not-allowed")
      }
    }
  }
}
// app/javascript/controllers/view_toggle_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["cardView", "tableView", "toggleLabel"]

  connect() {
    // Runs every time the element appears — even after Turbo navigation
    this.currentView = localStorage.getItem("contactView") || "cards"
    this.applyView()
  }

  switch() {
    this.currentView = this.currentView === "cards" ? "table" : "cards"
    localStorage.setItem("contactView", this.currentView)
    this.applyView()
  }

  applyView() {
    this.cardViewTarget.style.display  = this.currentView === "cards" ? "block" : "none"
    this.tableViewTarget.style.display = this.currentView === "table" ? "block" : "none"
    this.toggleLabelTarget.textContent = this.currentView === "cards" ? "⊞ Table View" : "⊟ Cards View"
  }
}
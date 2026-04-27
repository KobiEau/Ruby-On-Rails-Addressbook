// app/javascript/contact_view_toggle.js

let currentView = localStorage.getItem("contactView") || "cards";

function applyView(view) {
  document.getElementById("card-view").style.display  = view === "cards" ? "block" : "none";
  document.getElementById("table-view").style.display = view === "table" ? "block" : "none";
  document.getElementById("toggle-label").textContent = view === "cards" ? "⊞ Table View" : "⊟ Cards View";
}

function switchView() {
  currentView = currentView === "cards" ? "table" : "cards";
  localStorage.setItem("contactView", currentView);
  applyView(currentView);
}

document.addEventListener("DOMContentLoaded", () => {
  applyView(currentView);
  document.getElementById("view-toggle").addEventListener("click", switchView);
});
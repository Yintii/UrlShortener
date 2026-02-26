import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect(){
    console.log("Navbar controller connected")
    this.menuTarget.style.right = "-263px"
  }

  toggle() {
    this.menuTarget.style.right = this.menuTarget.classList.contains("hidden") ? "0px" : "-263px"
    if (this.menuTarget.classList.contains("hidden")) {
      this.menuTarget.classList.remove("hidden")
    } else {
      this.menuTarget.classList.add("hidden")
    }
  }
}

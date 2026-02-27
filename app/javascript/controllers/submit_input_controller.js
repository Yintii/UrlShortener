import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static targets = ["submit", "textInput", "radio", "shrtnAction", "qrAction"]

  connect() {
    console.log("Submit Input Controller Connected")
  }

  change() {
    if (!this.hasSubmitTarget) {
      console.error("Submit target not found!")
      return
    }

    const selected = this.radioTargets.find(r => r.checked)?.value

    if (selected === "qr") {
      this.submitTarget.textContent = "Generate"
      this.textInputTarget.placeholder = "EntrURL2CrtQR"
      this.qrActionTarget.classList.add("active-action")
      this.shrtnActionTarget.classList.remove("active-action")
    } else {
      this.submitTarget.textContent = "Shrtn"
      this.textInputTarget.placeholder = "EntrURL2Shrtn"
      this.shrtnActionTarget.classList.add("active-action")
      this.qrActionTarget.classList.remove("active-action")
    }
  }
}
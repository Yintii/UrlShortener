import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["canvas"]

  connect() {
    const unique = parseInt(this.canvasTarget.dataset.unique)
    const total = parseInt(this.canvasTarget.dataset.total)
    const repeat = total - unique

    new Chart(this.canvasTarget, {
      type: "doughnut",
      data: {
        labels: ["Unique Visitors", "Repeat Visitors"],
        datasets: [{
          data: [unique, repeat],
          backgroundColor: ["#4f46e5", "#e0e7ff"],
          borderWidth: 0
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: { position: "bottom" }
        }
      }
    })
  }
}
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["canvas"]

  connect() {
    console.log("chart controller connected", this.canvasTarget.dataset.clicks)

    const raw = JSON.parse(this.canvasTarget.dataset.clicks)
    const labels = Object.keys(raw)
    const data = Object.values(raw)

    new Chart(this.canvasTarget, {
      type: "line",
      data: {
        labels,
        datasets: [{
          label: "Clicks",
          data,
          borderColor: "#4f46e5",
          tension: 0.3,
          fill: false
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: { y: { beginAtZero: true } }
      }
    })
  }
}
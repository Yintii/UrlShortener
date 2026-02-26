import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["canvas"]

  connect() {
    console.log("Map controller connected!")
    
    const raw = this.canvasTarget.dataset.locations
    const locations = raw ? JSON.parse(raw) : []

    // Load Leaflet CSS
    if (!document.querySelector("#leaflet-css")) {
      const link = document.createElement("link")
      link.id = "leaflet-css"
      link.rel = "stylesheet"
      link.href = "https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
      document.head.appendChild(link)
    }

    // Load Leaflet JS then heat plugin then render
    this.loadScript("https://unpkg.com/leaflet@1.9.4/dist/leaflet.js", () => {
      this.loadScript("https://unpkg.com/leaflet.heat@0.2.0/dist/leaflet-heat.js", () => {
        this.renderMap(locations)
      })
    })
  }

  loadScript(src, callback) {
    if (document.querySelector(`script[src="${src}"]`)) {
      callback()
      return
    }
    const script = document.createElement("script")
    script.src = src
    script.onload = callback
    document.head.appendChild(script)
  }

  renderMap(locations) {
    const map = L.map(this.canvasTarget).setView([20, 0], 2)

    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
      attribution: "© OpenStreetMap contributors"
    }).addTo(map)
  
    if (!locations || locations.length === 0) return

    // Heatmap layer
    const heatPoints = locations.map(loc => [loc.lat, loc.lng, 1])
    L.heatLayer(heatPoints, {
      radius: 25,
      blur: 15,
      maxZoom: 10,
      gradient: { 0.4: "blue", 0.6: "lime", 0.8: "yellow", 1.0: "red" }
    }).addTo(map)

    // Individual markers with popups
    locations.forEach(loc => {
      L.circleMarker([loc.lat, loc.lng], {
        radius: 5,
        fillColor: "#6366f1",
        color: "#fff",
        weight: 1,
        fillOpacity: 0.8
      })
      .bindPopup(`${loc.city || "Unknown city"}, ${loc.country || "Unknown country"}`)
      .addTo(map)
    })
  }
}
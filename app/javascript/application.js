// app/javascript/application.js
import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"
import NavbarController from "controllers/navbar_controller"
import ChartController from "controllers/chart_controller"
import DonutController from "controllers/donut_controller"

const application = Application.start()
application.register("navbar", NavbarController)
application.register("chart", ChartController)
application.register("donut", DonutController)

if ("serviceWorker" in navigator) {
  window.addEventListener("load", () => {
    navigator.serviceWorker.register("/service-worker.js", { scope: "/" })
      .then((reg) => console.log("Service worker registered:", reg.scope))
      .catch((err) => console.error("Service worker error:", err));
  });
}
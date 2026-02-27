// app/javascript/application.js
import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"
import NavbarController from "controllers/navbar_controller"
import ChartController from "controllers/chart_controller"
import DonutController from "controllers/donut_controller"
import FlashController from "controllers/flash_controller"
import MapController from "controllers/map_controller"
import SubmitInputController from "controllers/submit_input_controller"


const application = Application.start()
application.register("navbar", NavbarController)
application.register("chart", ChartController)
application.register("donut", DonutController)
application.register("flash", FlashController)
application.register("map", MapController)
application.register("submit-input", SubmitInputController)


if ("serviceWorker" in navigator) {
  window.addEventListener("load", () => {
    navigator.serviceWorker.register("/service-worker.js", { scope: "/" })
      .then((reg) => console.log("Service worker registered:", reg.scope))
      .catch((err) => console.error("Service worker error:", err));
  });
}
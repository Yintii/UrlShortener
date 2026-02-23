// app/javascript/application.js
import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"
import NavbarController from "controllers/navbar_controller"
import ChartController from "controllers/chart_controller"

const application = Application.start()
application.register("navbar", NavbarController)
application.register("chart", ChartController)


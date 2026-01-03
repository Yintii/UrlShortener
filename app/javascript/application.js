// app/javascript/application.js
import { Application } from "@hotwired/stimulus"
import NavbarController from "./controllers/navbar_controller.js"

const application = Application.start()
application.register("navbar", NavbarController)

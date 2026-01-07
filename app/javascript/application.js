// app/javascript/application.js
import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"
import NavbarController from "controllers/navbar_controller"

const application = Application.start()
application.register("navbar", NavbarController)

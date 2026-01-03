import { Application } from "@hotwired/stimulus"
import NavbarController from "./controllers/navbar_controller.js"

// Start Stimulus application
const application = Application.start()

// Load your controllers manually (or you can use `importAll` if you add more)
application.register("navbar", NavbarController)

import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus-importmap-autoloader"

const application = Application.start()

// Automatically load all controllers from app/javascript/controllers
const context = require.context("./controllers", true, /\.js$/)
application.load(definitionsFromContext(context))

// Entry point for Stimulus
import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus-loading"

const application = Application.start()

// Automatically load all controllers from controllers folder
const context = require.context("./controllers", true, /\.js$/)
application.load(definitionsFromContext(context))

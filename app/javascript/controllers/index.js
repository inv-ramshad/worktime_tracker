import { Application } from "@hotwired/stimulus"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

const application = Application.start()

application.debug = true
window.Stimulus = application

eagerLoadControllersFrom("controllers", application)
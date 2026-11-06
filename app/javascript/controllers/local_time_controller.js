import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Local time controller connected!")

    this.element.querySelectorAll("[data-local-time]").forEach((element) => {
      const date = new Date(element.dataset.localTime)

      if (isNaN(date.getTime())) return

      element.textContent = date.toLocaleString()
    })
  }
}
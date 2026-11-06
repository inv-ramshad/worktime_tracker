import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  static targets = [
    "timer",
    "taskName",
    "sessionType"
  ]

  static targets = [
    "timer",
    "taskName",
    "sessionType",
    "focusSelect",
    "breakSelect"
  ]

  static values = {
    focusDuration: { type: Number, default: 25 },
    breakDuration: { type: Number, default: 5 }
  }

  connect() {
    this.mode = "focus"
    this.remainingSeconds = this.focusDurationValue * 60
    this.timerInterval = null

    this.updateDisplay()
  }

  start() {


    if (!this.taskNameTarget.value.trim()) {
      alert("Please enter a task name first.")
      return
    }

    if (this.mode === "focus" && !this.sessionStartedAt) {
      this.sessionStartedAt = new Date().toISOString()
    }
    if (this.timerInterval) return

    this.timerInterval = setInterval(() => {
      if (this.remainingSeconds > 0) {
        this.remainingSeconds--
        this.updateDisplay()
      } else {
        this.switchSession()
      }
    }, 1000)
  }

  pause() {
    clearInterval(this.timerInterval)
    this.timerInterval = null
  }

  reset() {
    this.pause()
    this.mode = "focus"
    this.remainingSeconds = this.focusDurationValue * 60
    this.updateDisplay()
  }

  switchSession() {
    if (this.mode === "focus") {
      console.log("Focus completed. Saving session...")

      this.saveSession()

      this.mode = "break"
      this.remainingSeconds = this.breakDurationValue * 60

      alert("Focus completed! Time for a break.")
    } else {
      this.mode = "focus"
      this.remainingSeconds = this.focusDurationValue * 60

      alert("Break completed! Back to work.")
    }
    this.updateDisplay()
  }

  updateDisplay() {
    const minutes = Math.floor(this.remainingSeconds / 60)
    const seconds = this.remainingSeconds % 60

    this.timerTarget.textContent =
      `${String(minutes).padStart(2, "0")}:${String(seconds).padStart(2, "0")}`

    this.sessionTypeTarget.textContent =
      this.mode === "focus" ? "Focus Session" : "Break Session"
  }

  changeFocusDuration() {
    this.focusDurationValue = Number(this.focusSelectTarget.value)

    if (this.mode === "focus") {
      this.remainingSeconds = this.focusDurationValue * 60
      this.updateDisplay()
    }
  }

  changeBreakDuration() {
    this.breakDurationValue = Number(this.breakSelectTarget.value)

    if (this.mode === "break") {
      this.remainingSeconds = this.breakDurationValue * 60
      this.updateDisplay()
    }
  }

  disconnect() {
    this.pause()
  }

 
  async saveSession() {
    const taskName = this.taskNameTarget.value.trim()

    if (!taskName) {
      alert("Please enter a task name before starting.")
      return
    }

    const csrfToken = document.querySelector(
      'meta[name="csrf-token"]'
    ).content

    try {
      const response = await fetch("/pomodoro_sessions", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": csrfToken,
          "Accept": "application/json"
        },
        body: JSON.stringify({
          task_name: taskName,
          focus_duration: this.focusDurationValue,
          break_duration: this.breakDurationValue,
          started_at: this.sessionStartedAt
        })
      })

      if (!response.ok) {
        throw new Error("Could not save the Pomodoro session.")
      }

      alert("Pomodoro session saved successfully!")
      this.sessionStartedAt = null
    } catch (error) {
      alert(error.message)
    }
  }
}
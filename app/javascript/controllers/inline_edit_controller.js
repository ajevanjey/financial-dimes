import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["display", "input"]
  static values = { url: String }

  connect() {
    this.originalValue = this.inputTarget.value
  }

  startEdit() {
    this.displayTarget.classList.add("d-none")
    this.inputTarget.classList.remove("d-none")
    this.inputTarget.focus()
    this.inputTarget.select()
  }

  cancel() {
    this.inputTarget.value = this.originalValue
    this.exitEdit()
  }

  async save() {
    const newTitle = this.inputTarget.value.trim()

    if (newTitle === "" || newTitle === this.originalValue) {
      this.cancel()
      return
    }

    try {
      const response = await fetch(this.urlValue, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({ chat: { title: newTitle } })
      })

      if (response.ok) {
        const data = await response.json()
        this.originalValue = data.title
        this.displayTarget.textContent = data.title
        this.exitEdit()
      } else {
        console.error("Failed to save title")
        this.cancel()
      }
    } catch (error) {
      console.error("Network error:", error)
      this.cancel()
    }
  }

  handleKeydown(event) {
    if (event.key === "Enter") {
      event.preventDefault()
      this.save()
    } else if (event.key === "Escape") {
      event.preventDefault()
      this.cancel()
    }
  }

  exitEdit() {
    this.inputTarget.classList.add("d-none")
    this.displayTarget.classList.remove("d-none")
  }
}

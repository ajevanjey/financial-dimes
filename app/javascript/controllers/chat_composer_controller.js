import { Controller } from "@hotwired/stimulus"

// Behaviour for the chat composer on chats/show.
//
// - Enter submits the form (via Turbo).
// - Shift+Enter inserts a newline.
// - IME composition (e.g. Japanese / Chinese input) is left alone so the
//   first Enter just commits the candidate.
// - Empty input is ignored.
// - The textarea auto-grows as you type, up to its CSS max-height.
//
// Wire-up:
//   form: data-controller="chat-composer"
//   textarea: data-chat-composer-target="input"
//             data-action="keydown->chat-composer#submitOnEnter input->chat-composer#autoGrow"
export default class extends Controller {
  static targets = ["input"]

  connect() {
    if (!this.hasInputTarget) return
    this.autoGrow()
    // Focus on first paint so the user can start typing immediately
    this.inputTarget.focus()
  }

  submitOnEnter(event) {
    if (event.key !== "Enter") return
    if (event.shiftKey || event.isComposing || event.keyCode === 229) return

    event.preventDefault()
    if (this.inputTarget.value.trim() === "") return

    // requestSubmit() is the right entry point — it goes through Turbo and
    // honours form validation. (form.submit() bypasses both.)
    this.element.requestSubmit()
  }

  autoGrow() {
    const ta = this.inputTarget
    ta.style.height = "auto"
    ta.style.height = `${ta.scrollHeight}px`
  }
}

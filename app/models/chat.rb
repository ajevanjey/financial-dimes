class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :stock, optional: true
  has_many :messages, dependent: :destroy

  TITLE_PROMPT = <<~PROMPT
    Generate a short, descriptive title (3 to 6 words max) that summarizes the user's question for a chat conversation.
    Return ONLY the title text, with no quotes, no punctuation at the end, and no extra explanation.
  PROMPT

  def generate_title_from_first_message
    return if title.present?

    first_user_message = messages.where(role: "user").order(:created_at).first
    return if first_user_message.nil?

    response = RubyLLM.chat(model: "gpt-4o-mini")
                    .with_instructions(TITLE_PROMPT)
                    .ask(first_user_message.content)
    update(title: response.content.strip)
  end
end

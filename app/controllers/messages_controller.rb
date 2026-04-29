class MessagesController < ApplicationController
  before_action :authenticate_user!

  SYSTEM_PROMPT = "You are a helpful financial assistant specialized in stock analysis. Provide clear, concise advice and explain financial concepts in simple terms."

  def create
    @chat = current_user.chats.find(params[:chat_id])
    @message = @chat.messages.new(message_params)
    @message.role = "user"

    if @message.save
      response = RubyLLM.chat(model: "gpt-4o-mini")
        .with_instructions(SYSTEM_PROMPT)
        .ask(@message.content)

      @chat.messages.create(role: "assistant", content: response.content)

      @chat.generate_title_from_first_message #line for chat title

      redirect_to chat_path(@chat)
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end

class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @chat = current_user.chats.find(params[:chat_id])
    @message = @chat.messages.new(message_params)
    @message.role = "user"

    if @message.save
      # Appel à l'IA avec le contenu du message du user
      response = RubyLLM.chat(model: "gpt-4o-mini").ask(@message.content)

      # Sauvegarde de la réponse comme nouveau message avec role: "assistant"
      @chat.messages.create(role: "assistant", content: response.content)

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

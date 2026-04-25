class ChatsController < ApplicationController
  before_action :authenticate_user!

  def create
    @chat = current_user.chats.create
    redirect_to chat_path(@chat)
  end

  def show
    @chat = current_user.chats.find(params[:id])
    @message = Message.new
  end

  def index
    @chats = current_user.chats.order(created_at: :desc)
  end

  def destroy
    @chat = current_user.chats.find(params[:id])
    @chat.destroy
    redirect_to chats_path, notice: "Chat supprimé"
  end

end

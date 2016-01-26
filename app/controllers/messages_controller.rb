class MessagesController < ApplicationController

  def create
    Message.create(change_params)
    redirect_to :back
    flash[:notice] = "投稿しました"
  end

  def update
    @message = Message.find(params[:id])
    @message.update(change_params)
    redirect_to :back
    flash[:notice] = "投稿しました。ありがとうございます。"
  end

  def change_params
    params.require(:message).permit(:venture_id, :mentor_id, :genre_id, :has_read, :content, :answer_content)
  end
end

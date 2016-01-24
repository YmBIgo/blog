class NotificationsController < ApplicationController

  before_action :create_check, only:[:destroy, :create]

  def create
    @notification = Notification.create(create_params)
    redirect_to :back
    flash[:notice] = "登録されました"
  end

  def index
    @notifications = Notification.page(params[:id]).order("created_at DESC")
  end

  private
  def create_params
    params.require(:notification).permit(:type_id, :user_id, :venture_id, :mentor_id, :coaching_id)
  end

  def create_check
    unless user_signed_in? || mentor_signed_in?
      redirect_to root_path
      flash[:alert] = "登録できません"
    end
  end

end

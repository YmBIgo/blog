class NotificationsController < ApplicationController
  def index
    @notifications = Notification.page(params[:id]).order("created_at DESC")
  end
end

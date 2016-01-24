class WelcomeController < ApplicationController
  def index
    @user = current_user
    @notifications = Notification.where(:type_id => [1, 3, 4]).order("created_at DESC").limit(5)
    if user_signed_in?
      if current_user.register_venture?
        @venture = Venture.where('owner = ?', current_user.id).first
      end
    end
  end
end

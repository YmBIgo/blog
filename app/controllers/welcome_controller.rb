class WelcomeController < ApplicationController
  def index
    @notifications = Notification.all.order("created_at DESC").limit(5)
    if user_signed_in?
      if current_user.register_venture?
        @venture = Venture.where('owner = ?', current_user.id).first
      end
    end
  end
end

class Notification < ActiveRecord::Base

  belongs_to :user
  belongs_to :mentors

  def notify_message
    if type_id==1
      @user       = User.find(user_id)
      @venture    = Venture.find(venture_id)
      "#{@user.name}が#{@venture.name}を公開しました"
    elsif type_id==2
      @user       = User.find(user_id)
      @venture    = Venture.find(venture_id)
    elsif type_id==3
      @user       = User.find(user_id)
      @mentor     = Mentor.find(mentor_id)
      "#{@user.name}が#{@mentor.name}に質問をしました"
    elsif type_id==4
      @user       = User.find(user_id)
      @mentor     = Mentor.find(mentor_id)
    else
      ""
    end
  end

end

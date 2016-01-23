class Notification < ActiveRecord::Base

  belongs_to :user
  belongs_to :mentors

  def notify_message
    if type_id==1
      @user = User.find(user_id)
      @venture = Venture.find(venture_id)
      "#{@user.name}さんが#{@venture.name}を公開しました"
    elsif type_id==2
      @user = User.find(user_id)
      @mentor = Mentor.find(mentor_id)
      "#{@user.name}さんが#{@mentor.name}さんに質問をしました"
    elsif type_id==3
      @user = User.find(user_id)
      @mentor = Mentor.find(mentor_id)
    else
      ""
    end
  end

end

class Notification < ActiveRecord::Base

  belongs_to :user
  belongs_to :mentors
  belongs_to :ventures

  def notify_message
    case type_id
    when 1 then
      @user       = User.find(user_id)
      @venture    = Venture.find(venture_id)
      "#{@user.name}が#{@venture.name}を公開しました"
    when 2 then
      @user       = User.find(user_id)
      @venture    = Venture.find(venture_id)
      "#{@venture.name}に#{@user.name}がジョインしました"
    when 3 then
      @user       = User.find(user_id)
      @venture    = Venture.find(venture_id)
      "#{@user.name}が#{@venture.name}に「いいね」をしました"
    when 4 then
      @user       = User.find(user_id)
      @mentor     = Mentor.find(mentor_id)
      "#{@user.name}が#{@mentor.name}に質問をしました"
    when 5 then
      @user       = User.find(user_id)
      @mentor     = Mentor.find(mentor_id)
      "#{@mentor.name}が#{@user.name}に回答しました"
    else
      ""
    end
  end

end

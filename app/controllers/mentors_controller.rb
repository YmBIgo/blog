class MentorsController < ApplicationController

  before_action :editable_mentor, only:[:edit, :update]

  def index
    @mentors = Mentor.all.page(params[:page])
  end
  def show
    @mentor = Mentor.find(params[:id])
    @messages = Message.all
    @message = Message.new
  end
  def edit
    @mentor = Mentor.find(params[:id])
  end
  def update
    @mentor = Mentor.find(params[:id])
    @mentor.update(update_params)
    redirect_to :back
    flash[:notice] = "編集完了しました"
  end

  def chat
    @user = User.find(params[:id])
    @messages = @user.messages
  end

  def chat_post
    @message = Message.create(:message_params)
  end

  private

  def editable_mentor
    @chk_mentor = Mentor.find(params[:id])
    if current_mentor.present?
      if current_mentor.id == @chk_mentor.id
      else
        redirect_to root_path
        flash[:alert] = "編集する権限はありません"
      end
    else
      redirect_to root_path
      flash[:alert] = "編集する権限はありません"
    end
  end

  def update_params
    params.require(:mentor).permit(:family_name, :first_name, :age, :belong, :self_intro, :m_image)
  end

  def change_params
    params.require(:venture).permit(:name, :v_image, :explain, :reason, :vision, :job_offer, :owner)
  end

end

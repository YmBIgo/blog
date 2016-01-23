class MentorsController < ApplicationController

  before_action :editable_mentor, only:[:edit, :update]

  def index
  end
  def show
    @mentor = Mentor.find(params[:id])
  end
  def edit
    @mentor = Mentor.find(params[:id])
  end
  def update
    @mentor = Mentor.find(params[:id])
    @mentor.update(update_params)
  end

  private

  def editable_mentor
    @chk_mentor = Mentor.find(params[:id])
    if current_mentor.present?
      if current_mentor.id == @chk_mentor.id
      else
        redirect_to root_path
        flash[:error] = "編集する権限はありません"
      end
    else
      redirect_to root_path
      flash[:error] = "編集する権限はありません"
    end
  end

  def update_params
    params.require(:mentors).permit(:family_name, :first_name, :age, :belong, :self_intro, :m_image)
  end

end

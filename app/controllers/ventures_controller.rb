class VenturesController < ApplicationController

  before_action :authenticate_user!,   only:[:new, :create, :edit, :update]
  before_action :check_venture_exist,  only:[:new, :create]
  before_action :editable_user,        only:[:edit, :update]

  def new
    @venture = Venture.new
  end
  def create
    @venture = Venture.create(change_params)
    redirect_to venture_path(@venture.id)
    flash[:notice] = "登録が完了しました"
  end
  def index
    if user_signed_in?
      @venture = Venture.where('owner = ?', current_user.id).first
    end
  end
  def show
    @venture = Venture.find(params[:id])
  end
  def edit
    @venture = Venture.find(params[:id])
  end
  def update
    @venture = Venture.find(params[:id])
    @venture.update(change_params)
    redirect_to venture_path(@venture.id)
    flash[:notice] = "編集が完了しました"
  end

  private

  def check_venture_exist
    if current_user.register_venture?
      redirect_to root_path
      flash[:alert] = "登録できる事業は一つまでです"
    end
  end

  def owner_user
    User.find(Venture.find(params[:id]).owner)
  end

  def editable_user
    @user = owner_user
    unless current_user == owner_user
      redirect_to root_path
      flash[:alert] = "編集できません"
    end
  end

  def change_params
    params.require(:venture).permit(:name, :v_image, :explain, :reason, :vision, :job_offer, :owner)
  end

end
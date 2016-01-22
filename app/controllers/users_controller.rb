class UsersController < ApplicationController

  before_action :authenticate_user!, only:[:edit, :update]
  before_action :editable_user     , only:[:edit, :update]
  before_action :find_owned_venture

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(update_params)
    redirect_to :back
    flash[:notice] = "編集完了しました"
  end

  private

  def update_params
    params.require(:user).permit(:family_name, :first_name, :image, :belong, :age, :self_intro)
  end

  def editable_user
    @check_user = User.find(params[:id])
    unless @check_user.id == current_user.id
      redirect_to root_path
    end
  end

  def find_owned_venture
    if user_signed_in?
      @venture = Venture.where('owner = ?', current_user.id).first
    end
  end

end

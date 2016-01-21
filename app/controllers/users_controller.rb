class UsersController < ApplicationController

  before_action :authenticate_user!, only:[:edit, :update]

  def index
  end
  def show
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    @user.update(update_params)
  end

  private

  def update_params
    params.require(:user).permit(:family_name, :first_name, :image, :belong, :age, :self_intro)
  end

end

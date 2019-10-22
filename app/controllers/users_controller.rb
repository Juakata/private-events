class UsersController < ApplicationController
  before_action :logged_in, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @events = current_user.events
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def logged_in
    redirect_to root_path unless log_in?
  end
end

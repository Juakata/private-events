class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_name(params[:session][:name])

    if user
      log_in user
      redirect_to user
    else
      render 'new'
    end
  end

  def destroy
    sign_out if log_in?
    redirect_to root_path
  end
end

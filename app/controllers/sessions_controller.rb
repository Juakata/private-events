# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :logged_in, only: %i[new create]

  def new; end

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

  def logged_in
    redirect_to current_user if log_in?
  end
end

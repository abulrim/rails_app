class SessionsController < ApplicationController
  before_action :check_logged_out, except: [:destroy]

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])

    if user && user.authenticate(params[:session][:password])
      log_in(user)
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to root_url
    else
      flash.now[:alert] = "Email or password is invalid"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def check_logged_out
    if logged_in?
      redirect_to root_url
    end
  end
end

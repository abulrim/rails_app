# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :check_logged_out, except: [:destroy]

  def new; end

  def create
    user = User.find_by_email(params[:session][:email])

    if user&.authenticate(params[:session][:password])
      login_and_redirect(user)
    else
      flash.now[:alert] = 'Email or password is invalid'
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def check_logged_out
    redirect_to root_url if logged_in?
  end

  private

  def login_and_redirect(user)
    log_in(user)
    params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    redirect_to root_url
  end
end

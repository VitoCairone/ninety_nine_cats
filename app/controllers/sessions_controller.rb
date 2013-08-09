class SessionsController < ApplicationController

  def create
    user = User.find_by_username(params[:login][:username])
    if user.nil?
      render :text => "Username not found, go back and try again!"
      return
    end

    unless user.verify_password?(params[:login][:password])
      render :text => "Incorrect password."
      return
    end

    token = SecureRandom.urlsafe_base64(16)
    session[:token] = token
    user.session_token = token
    user.save!

    redirect_to cats_url
  end

  def new
    render :new
  end


end

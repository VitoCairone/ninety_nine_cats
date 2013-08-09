class UsersController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.create!(params[:user])

    render :text => "User #{user.username} created"
  end
end

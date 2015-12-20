class UsersController < ApplicationController

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])
    @liked_stories = Story.all_liked(user_id: params[:id]).page(params[:page])
    @contributed_stories = Story.all_contributed(user_id: params[:id]).page(params[:page])
  end
  
end

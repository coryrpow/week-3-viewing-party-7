class MoviesController < ApplicationController
  before_action :current_user
  
  def index 
      # @user = User.find(params[:id])
      @movies = Movie.all
  end 

  def show 
      # @user = User.find(params[:user_id])
      @movie = Movie.find(params[:id])
  end 

  private

  def current_user
    @user = User.find(session[:user_id])
  end
end 
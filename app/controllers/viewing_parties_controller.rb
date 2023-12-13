class ViewingPartiesController < ApplicationController 
  before_action :require_login, only: [:new, :create]

  def new
    @user = User.find(session[:user_id])
    @movie = Movie.find(params[:movie_id])
  end 
  
  def create 
    user = User.find(session[:user_id])
    user.viewing_parties.create(viewing_party_params)
    redirect_to "/users/#{params[:user_id]}"
  end 

  private 

  def viewing_party_params 
    params.permit(:movie_id, :duration, :date, :time)
  end

  def require_login
    unless session[:user_id] != nil
      flash[:error] = "You gotta log in, bruh. Can't create a viewing party without logging in."
      redirect_to "/movies/#{params[:movie_id]}"
    end
  end
 
end 
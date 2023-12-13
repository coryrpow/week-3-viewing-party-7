class UsersController <ApplicationController
  before_action :require_login, only: [:show]

  def new 
    @user = User.new()
  end 

  def show 
    @user = User.find(session[:user_id])
  end 

  def create 
    user = user_params
    user[:name] = user[:name].downcase
    new_user = User.create(user)
    session[:user_id] = new_user.id
    if new_user.save
      flash[:success] = "Welcome, #{new_user.name}!"
      redirect_to user_path(new_user)
    else  
      flash[:error] = new_user.errors.full_messages.to_sentence
      redirect_to register_path
    end 
  end

  def login_form; end 

  def login
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash[:error] = "Bzzt, wrongo, try again."
      render :login_form
    end
  end

  def logout
    session.clear
    redirect_to root_path
  end

  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 

  def require_login
    unless session[:user_id] != nil
      flash[:error] = "You gotta log in, bruh. Can't see your dashboard without logging in."
      redirect_to root_path
    end
  end
end 
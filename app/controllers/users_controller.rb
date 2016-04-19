class UsersController < ApplicationController

  #before_filter :login_required, except: [:new, :create]
  
  def index
  end

  def show
  end

  def new
    @user = User.find(current_user)
  end

  def edit
    @user = User.find(current_user)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to home_path, notice: "Thank you for signing up!"
    else
      flash[:error] = "This user could not be created."
      render "new"
    end
  end

  def update
    
  end

  def destroy

  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :employee_id)
  end

end

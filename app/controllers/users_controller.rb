class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index]
  before_action :correct_user,   only:   [:edit, :update]

#rails generate migration add_admin_to_users admin:boolean

  def index
    @users = User.paginate(page: params[:page])
    #code
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    #code
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the sample app"
      render 'show'
    else
      flash[:error] = "There was a problem  signing up"
      render 'new'
    end
    #code
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      flash[:error] = (" the was a problem with user update")
      render 'edit'
    end
    #code
  end

  private

  def user_params
    params.require(:user).permit(
    :name,
    :email,
    :password,
    :password_confirmation)
    #code
  end
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_url
    end
  end
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end

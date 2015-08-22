class Admin::UsersController < ApplicationController
  def index
    @users = policy_scope(User).where.not(id: current_user)
    authorize @users
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    params[:password_confirmation] = params[:password]
    @user = User.new(admin_user_params)
    if @user.save
      redirect_to admin_users_url
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def destroy
    @user = User.find(params[:id])
    authorize @user
    @user.destroy
    redirect_to admin_users_url
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    @user = User.find(params[:id])
    authorize @user
    if @user.update(admin_user_params)
      redirect_to admin_users_url
    else
      render :edit
    end
  end

  def admin_user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end
end

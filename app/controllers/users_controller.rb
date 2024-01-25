class UsersController < ApplicationController
  /before_action :set_user, only: %i[show edit update destroy]/
  before_action :require_login, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.card_number = SecureRandom.hex(8).upcase
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  before_action :require_login

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user&.authenticate(params[:user][:current_password])
      @user.password = params[:user][:new_password]
      generate_and_save_password_combinations
  
      if @user.save
        redirect_to transactions_path, notice: 'Password and selected_characters updated successfully.'
      else
        render :edit
      end
    else
      flash.now[:alert] = 'Invalid current password.'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :card_number, :mail, :identity_document)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end

  private

  def require_login
    redirect_to login_path unless logged_in?
  end
end

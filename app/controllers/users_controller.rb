class UsersController < ApplicationController
  before_action :require_login, except: [:create, :new]

  def index
  end

  def show
    @user = User.find(session[:user_id])
    if User.find(session[:user_id]) != User.find(params[:id])
      session[:user_id] = nil
      redirect_to root_path
    end
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

  def edit
    @user = current_user
  end

  def update
    @user = User.find(session[:user_id])
    
    if @user&.authenticate(user_params[:current_password]) && user_params[:password] == user_params[:password_confirmation]
      Rails.logger.info('Current password is valid.')
      if @user.update(password: user_params[:password])
        @user.generate_and_save_password_combinations
        redirect_to transactions_path, notice: 'Password and selected_characters updated successfully.'
      else
        flash.now[:alert] = "Error: #{user.errors.full_messages.join(', ')}"
        render :edit
      end
    else
      flash.now[:alert] = 'Invalid current password or passwords do not match.'
      render :edit
    end
  end    

  private

  /def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end/

  def set_user
    @user = User.find(session[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :card_number, :mail, :identity_document, :password_confirmation, :current_password)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = 'Please log in.'
      redirect_to root_path
    end
  end

  def require_login
    redirect_to root_path unless logged_in?
  end
end

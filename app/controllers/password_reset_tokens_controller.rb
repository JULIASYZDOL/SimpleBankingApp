class PasswordResetTokensController < ApplicationController
    before_action :set_password_reset_token, only: %i[show edit update destroy]
  
    def index
      @password_reset_tokens = PasswordResetToken.all
    end
  
    def show
    end
  
    def new
      @password_reset_token = PasswordResetToken.new
    end
  
    def create
      @password_reset_token = PasswordResetToken.new(password_reset_token_params)
      if @password_reset_token.save
        redirect_to @password_reset_token, notice: 'Password Reset Token was successfully created.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @password_reset_token.update(password_reset_token_params)
        redirect_to @password_reset_token, notice: 'Password Reset Token was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @password_reset_token.destroy
      redirect_to password_reset_tokens_url, notice: 'Password Reset Token was successfully destroyed.'
    end
  
    private
  
    def set_password_reset_token
      @password_reset_token = PasswordResetToken.find(params[:id])
    end
  
    def password_reset_token_params
      params.require(:password_reset_token).permit(:user_id, :token)
    end
  end
  
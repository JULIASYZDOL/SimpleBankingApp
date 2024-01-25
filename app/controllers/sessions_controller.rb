class SessionsController < ApplicationController
  def new
    @user = User.find_by(mail: params[:mail])
    @user.selected_characters_combination = current_user.selected_characters_combination if current_user&.selected_characters_combination
  end

  def create
    @user = User.find_by(mail: params[:mail])

    if @user
      session[:user_id] = @user.id
      redirect_to password_combination_sessions_path
    else
      flash.now[:alert] = "Invalid email."
      render :new
    end
  end

  def password_combination
    @user = User.find(session[:user_id])
    @character_positions = @user.selected_characters_combination&.character_positions
  end
  
  def validate_characters
    @user = User.find(session[:user_id])
    max_attempts = 3
    sleep_seconds = 30
  
    puts "Params: #{params.inspect}"
  
    if @user.authenticate_with_selected_characters(params[:user][:selected_characters])
      redirect_to transactions_path
      session[:login_attempts] = 0
    else
      sleep(sleep_seconds)
  
      session[:login_attempts] ||= 0
      session[:login_attempts] += 1
  
      if session[:login_attempts] >= max_attempts
        redirect_to root_path, alert: 'Exceeded login attempts limit. Account locked.'
        return
      end
  
      redirect_to password_combination_sessions_path, aler: 'Wrong data'
    end
  end
  

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:mail)
  end
end

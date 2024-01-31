class SessionsController < ApplicationController
  def new
    @user = User.find_by(mail: params[:mail].to_s)
    /@user.selected_characters_combination = current_user.selected_characters_combination if current_user&.selected_characters_combination/
  end

  def create
    @user = User.find_by(mail: params[:mail].to_s)

    if @user
      session[:mail] = @user.mail
      redirect_to password_combination_sessions_path
    else
      flash.now[:alert] = "Invalid email."
      render :new
    end
  end

  def password_combination
    @user = User.find_by(mail: session[:mail].to_s)
    @character_positions = @user.selected_characters_combination&.character_positions
  end
  
  def validate_characters
    @user = User.find_by(mail: session[:mail].to_s)
    max_attempts = 3
    sleep_seconds = 30
  
    puts "Params: #{params.inspect}"
  
    if @user.authenticate_with_selected_characters(params[:selected_characters])
      session[:user_id] = @user.id
      session[:login_attempts] = 0
      redirect_to transactions_path 
    else
      session[:user_id] = nil
      sleep(sleep_seconds)
  
      session[:login_attempts] ||= 0
      session[:login_attempts] += 1
  
      if session[:login_attempts] >= max_attempts
        redirect_to root_path, alert: 'Exceeded login attempts limit. Account locked.'
        return
      end
  
      redirect_to password_combination_sessions_path, alert: 'Wrong data'
    end
  end
  

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:mail, :user, :selected_characters)
  end
end
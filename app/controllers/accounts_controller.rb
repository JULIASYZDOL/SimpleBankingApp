class AccountsController < ApplicationController
    before_action :require_login
    before_action :set_account, only: %i[show edit update destroy]
  
    def index
      @accounts = Account.all
    end
  
    def show
      @user = User.find(session[:user_id])
      if User.find(session[:user_id]) != User.find(params[:id])
        session[:user_id] = nil
        redirect_to root_path
      end
    end
  
    def new
      @account = Account.new
    end
  
    def create
      @account = Account.new(account_params)
      if @account.save
        redirect_to @account, notice: 'Account was successfully created.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      /if @account.update(account_params)
        redirect_to @account, notice: 'Account was successfully updated.'
      else
        render :edit
      end/
    end
  
    /def destroy
      @account.destroy
      redirect_to accounts_url, notice: 'Account was successfully destroyed.'
    end/
  
    private
  
    def set_account
      @account = Account.find(params[:id])
    end
  
    def account_params
      params.require(:account).permit(:account_number, :balance)
    end
  end
  
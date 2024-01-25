class TransactionsController < ApplicationController
    helper_method :current_user, :logged_in?

    before_action :require_login
    before_action :set_transaction, only: %i[show edit update destroy]
  
    def index
      @sent_transactions = current_user.sent_transactions
      @received_transactions = current_user.received_transactions
      @transactions = @sent_transactions + @received_transactions
    end 
  
    def show
    end
  
    def new
      @transaction = Transaction.new
    end
  
    def create
      @transaction = Transaction.new(transaction_params)
      @transaction.sender = current_user.accounts.first
    
      recipient_account_number = params[:transaction][:recipient_account_number]
      recipient = Account.find_by(account_number: recipient_account_number)
    
      if recipient
        @transaction.receiver = recipient
      else
        flash.now[:alert] = 'Recipient account not found.'
        render :new and return
      end
    
      if @transaction.save
        redirect_to transactions_path, notice: 'Transaction was successfully created.'
      else
        render :new
      end
    end    
  
    def edit
    end
  
    def update
      if @transaction.update(transaction_params)
        redirect_to @transaction, notice: 'Transaction was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @transaction.destroy
      redirect_to transactions_url, notice: 'Transaction was successfully destroyed.'
    end
  
    private
  
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end
  
    def transaction_params
      params.require(:transaction).permit(:amount, :title, :recipient_name, :recipient_account_number)
    end    

    def require_login
      unless logged_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to root_path
      end
    end
  end
  
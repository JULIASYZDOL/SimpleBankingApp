class TransactionsController < ApplicationController
    helper_method :current_user, :logged_in?

    before_action :require_login
    before_action :set_transaction, only: %i[show edit update destroy]
  
    def index
      transaction_account_balance
      @transactions = Transaction.where(sender_id: current_user.accounts.pluck(:id))
                                 .or(Transaction.where(receiver_id: current_user.accounts.pluck(:id)))
    end 
  
    def show
      @transaction = Transaction.find(params[:id])
  
      unless current_user.accounts.exists?(@transaction.sender_id) || current_user.accounts.exists?(@transaction.receiver_id)
        flash[:error] = "You are not authorized to view this transaction."
        redirect_to transactions_path
      end
    end
  
  
    def new
      @transaction = Transaction.new
    end
  
    def create
      @transaction = Transaction.new(transaction_params)
    
      sender_account = current_user.accounts.first
      @transaction.sender = sender_account
    
      recipient_account_number = params[:transaction][:recipient_account_number]
      recipient = Account.find_by(account_number: recipient_account_number)
    
      if recipient
        @transaction.receiver = recipient
      else
        flash.now[:alert] = 'Recipient account not found.'
        render :new and return
      end

      amount = params[:transaction][:amount].to_f

      if amount <= 0 || amount.to_s != params[:transaction][:amount] || amount.to_s.split(".")[1].to_s.length > 2
        flash.now[:alert] = 'Invalid amount.'
        render :new and return
      end

      if amount > sender_account.balance
        flash.now[:alert] = 'Insufficient funds.'
        render :new and return
      end

      sender_account.balance -= params[:transaction][:amount].to_f
      recipient.balance += params[:transaction][:amount].to_f

      ActiveRecord::Base.transaction do
        sender_account.save!
        recipient.save!
        @transaction.save!
      end
    
      if @transaction.save
        redirect_to transactions_path, notice: 'Transaction was successfully created.'
      else
        render :new
      end

      rescue ActiveRecord::RecordInvalid => e
        flash.now[:alert] = e.record.errors.full_messages.join(', ')
        render :new
    end        
  
    def edit
    end
  
    def update
      /if @transaction.update(transaction_params)
        redirect_to @transaction, notice: 'Transaction was successfully updated.'
      else
        render :edit
      end/
    end

    def transaction_account_balance
      sender_account = current_user.accounts.first
      @balance = sender_account.balance
    end
      
    def destroy
      /@transaction.destroy
      redirect_to transactions_url/
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
  
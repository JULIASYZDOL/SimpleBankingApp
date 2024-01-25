class SensitiveDataController < ApplicationController
    before_action :set_sensitive_data, only: %i[show edit update destroy]
  
    def index
      @sensitive_data_list = SensitiveData.all
    end
  
    def show
    end
  
    def new
      @sensitive_data = SensitiveData.new
    end
  
    def create
      @sensitive_data = SensitiveData.new(sensitive_data_params)
      if @sensitive_data.save
        redirect_to @sensitive_data, notice: 'Sensitive Data was successfully created.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @sensitive_data.update(sensitive_data_params)
        redirect_to @sensitive_data, notice: 'Sensitive Data was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @sensitive_data.destroy
      redirect_to sensitive_data_index_url, notice: 'Sensitive Data was successfully destroyed.'
    end
  
    private
  
    def set_sensitive_data
      @sensitive_data = SensitiveData.find(params[:id])
    end
  
    def sensitive_data_params
      params.require(:sensitive_data).permit(:card_number, :identity_document)
    end
  end
  
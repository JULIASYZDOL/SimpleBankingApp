class PasswordCombinationsController < ApplicationController
    def show
      @password_combination = PasswordCombination.find(params[:id])
    end
  end
  
class PasswordCombinationsController < ApplicationController
  @password_combination = PasswordCombination.find(params[:id])
end
  
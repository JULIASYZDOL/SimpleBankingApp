class CspReportsController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    def report
      report_data = JSON.parse(request.body.read)
      render json: {}, status: :ok
    end
  end
  
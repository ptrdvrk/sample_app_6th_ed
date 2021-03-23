class ApplicationController < ActionController::Base
  include SessionsHelper

  skip_before_action :verify_authenticity_token, 
    if: Proc.new { ENV['SWAGGER'] == 'true' }

  private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end

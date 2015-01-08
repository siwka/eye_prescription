class StaticPagesController < ApplicationController
	
  def home
  	@prescription = current_user.prescriptions.build if logged_in?
  end
end

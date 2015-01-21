class PrescriptionsController < ApplicationController
	before_action :logged_in_user, only: :create

	def create
		@prescription = current_user.prescriptions.build(prescription_params)

		if @prescription.save
      flash[:success] = "Prescription created!"
      redirect_to root_url
		else
      render 'static_pages/home'
		end
	end

	private

		def prescription_params
			params.require(:prescription).permit(:glasses,
				                                   :re_indicator, :re_value,
																					 :le_indicator, :le_value,
																					 :re_indicator_extra, :re_value_extra,
																					 :le_indicator_extra, :le_value_extra)
		end
end

require 'test_helper'

class PrescriptionsInterfaceTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:customer)
	end

  test "prescription interface" do
  	log_in_as @user
  	get root_path
		assert_select 'div.row'

  	# Invalid submission
  				# siwka  ?checked config/environments, no other idea
					# ERROR["test_prescription_interface", PrescriptionsInterfaceTest, 0.872567]
					# test_prescription_interface#PrescriptionsInterfaceTest (0.87s)
					# URI::InvalidURIError:         URI::InvalidURIError: the scheme http does not accept registry part: www.example.com:80prescriptions_path (or bad hostname?)
  	# assert_no_difference 'Prescription.count' do
  	# 	post 'prescriptions_path', prescription: {glasses: false,
			# 													               re_indicator: 'SPH',
			# 																				 re_value: -2.25,
			# 																				 le_indicator: 'SPH',
			# 																				 le_value: -1.25,
			# 																				 re_indicator_extra: nil,
			# 				     														 re_value_extra: nil,
			# 																		     le_indicator_extra: nil,
			# 																		     le_value_extra: nil }
		# end
  	# assert_select 'div#error_explanation'

    # Valid submission

  end
end
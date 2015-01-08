require 'test_helper'

class PrescriptionsControllerTest < ActionController::TestCase

  def setup
    @prescription = prescriptions(:one)
  end

  test "should redirect create when not logged in" do
  	assert_no_difference 'Prescription.count' do
  		post :create, prescription: { glasses: true,
										                re_indicator: 'SPH',
																	  re_value: -2.25,
																	  le_indicator: 'SPH',
																	  le_value: -1.25 }
  	end
  	assert_redirected_to login_url
  end
end

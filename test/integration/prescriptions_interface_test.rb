require 'test_helper'

class PrescriptionsInterfaceTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:customer)
	end

  test "prescription interface" do
  	log_in_as @user
  	get root_path
  end

end

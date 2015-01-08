require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest

	def setup
    @user = users(:customer)
  end

  test "profile display" do
  	get user_path(@user)
  	assert_template 'users/show'
  	assert_select 'title', @user.name
  	assert_select 'h3', text: "Prescription (#{@user.prescriptions.count})"
    assert_match @user.prescriptions.count.to_s, response.body
    @user.prescriptions.paginate(page: 1).each do |prescription|
      assert_match prescription.re_indicator, response.body
    end		
  end
end

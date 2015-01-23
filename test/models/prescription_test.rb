require 'test_helper'

class PrescriptionTest < ActiveSupport::TestCase

	def setup
		@user = users(:customer)
		@prescription = @user.prescriptions.build( glasses: true,
																               re_indicator: :SPH,
																							 re_value: -2.25,
																							 le_indicator: :SPH,
																							 le_value: -1.25,
																							 re_indicator_extra: '',
							     														 re_value_extra: nil,
																					     le_indicator_extra: '',
																					     le_value_extra: nil )
	end

  test "should be valid" do
  	assert @prescription.valid?
  end

  test "user id should be present" do
  	@prescription.user_id = nil
  	assert_not @prescription.valid?
  end

  test "glasses should be present" do
  	@prescription.glasses = nil
  	assert_not @prescription.valid?
  end

  test "re_indicator should be present" do
  	@prescription.re_indicator = nil
  	assert_not @prescription.valid?
  end

  test "re_value should be present" do
  	@prescription.re_value = nil
  	assert_not @prescription.valid?
  end

  test "le_indicator should be present" do
  	@prescription.le_indicator = nil
  	assert_not @prescription.valid?
  end

  test "le_value should be present" do
  	@prescription.le_value = nil
  	assert_not @prescription.valid?
  end

  test "re_value should not be a string" do
  	@prescription.re_value = 'temp'
  	assert_not @prescription.valid?
  end

  test "re_value should be a number" do
  	@prescription.re_value = 2.25
  	assert @prescription.valid?
  end

  test "le_value should not be a string" do
  	@prescription.le_value = 'temp'
  	assert_not @prescription.valid?
  end

  test "le_value should be a number" do
  	@prescription.le_value = 2.25
  	assert @prescription.valid?
  end

# conditional validations
  test "re_value should be a number (7..9), 0.1 diff, if right eye BC" do
    @prescription.glasses = false
    @prescription.re_indicator = 'BC'
    @prescription.re_value = 8.4
    assert @prescription.valid?
  end

  test "le_value should be a number (7..9), 0.1 diff, if left eye BC" do
    @prescription.glasses = false
    @prescription.le_indicator = 'BC'
    @prescription.le_value = 6
    assert_not @prescription.valid?
  end

  test "re_value should be a number (13..15), 0.1 diff, if right eye DIAM" do
    @prescription.glasses = false
    @prescription.re_indicator = 'DIAM'
    @prescription.re_value = 14.4
    assert @prescription.valid?
  end

  test "le_value should be a number (13..15), 0.1 diff, if left eye DIAM" do
    @prescription.glasses = false
    @prescription.le_indicator = 'DIAM'
    @prescription.le_value = 6
    assert_not @prescription.valid?
  end  

  test "re_value_extra should be nil if re_indicator is not CYL or AXIS" do
  	@prescription.re_value_extra = 2
  	assert_not @prescription.valid?
  end

  test "le_value_extra should be nil if le_indicator is not CYL or AXIS" do
  	@prescription.le_value_extra = 2
  	assert_not @prescription.valid?
  end

  test "re_indicator_extra should be nil if re_indicator is not CYL or AXIS" do
  	@prescription.re_indicator_extra = :CYL
  	assert_not @prescription.valid?
  end

  test "le_indicator_extra should be nil if le_indicator is not CYL or AXIS" do
  	@prescription.le_indicator_extra = :CYL
  	assert_not @prescription.valid?
  end   

  test "re_value_extra should not be a string" do
  	@prescription.re_indicator = :CYL
  	@prescription.re_value_extra = 'temp'
  	assert_not @prescription.valid?
  end

  test "re_indicator_extra should not be a empty if right eye CYL" do
  	@prescription.re_indicator = :CYL
  	assert_not @prescription.valid?
  end

  test "re_indicator_extra should be AXIS if right eye CYL" do
  	@prescription.re_indicator = 'CYL'
  	@prescription.re_indicator_extra = 'AXIS'
    @prescription.re_value_extra = 4
  	assert @prescription.valid?
  end

  test "re_value_extra should be a number if right eye CYL" do
  	@prescription.re_indicator = 'CYL'
  	@prescription.re_value_extra = 55
  	@prescription.re_indicator_extra = 'AXIS'
  	assert @prescription.valid?
  end  

  test "re_value_extra should be an integer number if right eye CYL" do
  	@prescription.re_indicator = :CYL
  	@prescription.re_indicator_extra = :AXIS
    @prescription.re_value_extra = 4.25
  	assert_not @prescription.valid?
  end


  test "le_value_extra should not be a string" do
  	@prescription.le_indicator = :CYL
  	@prescription.le_value_extra = 'temp'
  	assert_not @prescription.valid?
  end

  test "le_indicator_extra should not be a empty if left eye CYL" do
  	@prescription.le_indicator = :CYL
  	assert_not @prescription.valid?
  end 

  test "le_indicator_extra should be AXIS if left eye CYL" do
  	@prescription.le_indicator = :CYL
  	@prescription.le_value_extra = 26  	
  	@prescription.le_indicator_extra = :AXIS
  	assert @prescription.valid?
  end

  test "le_value_extra should be a number if left eye CYL" do
  	@prescription.le_indicator = :CYL
  	@prescription.le_value_extra = 61  	
  	@prescription.le_indicator_extra = :AXIS
  	assert @prescription.valid?
  end  

  test "le_value_extra should be an integer number if left eye CYL" do
  	@prescription.le_indicator = :CYL
  	@prescription.le_value_extra = 4.25  	
  	@prescription.le_indicator_extra = :AXIS
  	assert_not @prescription.valid?
  end  

  test "le_indicator_extra should not be nil if left eye CYL" do
  	@prescription.le_indicator = :CYL
  	assert_not @prescription.valid?
  end 

  test "le_indicator_extra should be CYL if left eye AXIS" do
  	@prescription.le_indicator = :AXIS
  	@prescription.le_value = 4
  	@prescription.le_indicator_extra = :CYL
  	@prescription.le_value_extra = -0.25  	  	
  	assert @prescription.valid?
  end

  test "le_value_extra should be a number if left eye AXIS" do
  	@prescription.le_indicator = :AXIS
    @prescription.le_value = 79
  	@prescription.le_value_extra = -5.75  	
  	@prescription.le_indicator_extra = :CYL
  	assert @prescription.valid?
  end  

  test "le_value_extra should not be an integer number if left eye AXIS" do
  	@prescription.le_indicator = :AXIS
    @prescription.le_value = 66
  	@prescription.le_value_extra = 4  	
  	@prescription.le_indicator_extra = :CYL
  	assert_not @prescription.valid?
  end

  test "re_value_extra should not be an integer number if right eye AXIS" do
    @prescription.re_indicator = :AXIS
    @prescription.re_value = 66
    @prescription.re_value_extra = 4    
    @prescription.re_indicator_extra = :CYL
    assert_not @prescription.valid?
  end

  test "le_value & le_value_extra should be numbers from specific range if left eye AXIS" do
    @prescription.le_indicator = :AXIS
    @prescription.le_value = 66
    @prescription.le_value_extra = -4.25    
    @prescription.le_indicator_extra = :CYL
    assert @prescription.valid?
  end  

  test "re_value & re_value_extra should be numbers from specific range if right eye AXIS" do
    @prescription.re_indicator = :AXIS
    @prescription.re_value = 66
    @prescription.re_value_extra = -4.25    
    @prescription.re_indicator_extra = :CYL
    assert @prescription.valid?
  end   

  test "BC le_indicator is only present for contact lens prescriptions" do
  	@prescription.glasses = true
  	@prescription.le_indicator = 'BC'
  	assert_not @prescription.valid?
  end

  test "DIAM re_indicator is only present for contact lens prescriptions" do
  	@prescription.glasses = true
  	@prescription.re_indicator = 'DIAM'
  	assert_not @prescription.valid?
  end


  test "order should be most recent first" do
    assert_equal Prescription.first, prescriptions(:most_recent)
  end
end

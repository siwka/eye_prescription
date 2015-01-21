class Prescription < ActiveRecord::Base
  belongs_to :user#, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates_inclusion_of :glasses, in: [true, false] # add test view works
  validates_inclusion_of :re_indicator, :le_indicator,
                           in: CRITERIA.keys.map(&:to_s),
                           message: "should be any of %w(:SPH :CYL :AXIS :BC :DIAM)"
  validates :re_value, :le_value, presence: true, numericality: true

  with_options if: :glasses do |presc|
    presc.validates :re_indicator, exclusion: { in: %w(BC DIAM),
                            message: "%{value} present only for contact lens prescription" }
    presc.validates :le_indicator, exclusion: { in: %w(BC DIAM),
                            message: "%{value} present only for contact lens prescription" }
  end   

  with_options if: :re_is_cyl? do |presc|
    presc.validates_inclusion_of :re_indicator_extra, in: %w(AXIS),
    												message: "with right eye CYL only AXIS is valid"
    presc.validates :re_value_extra, inclusion: { in: CRITERIA[:AXIS][0]..CRITERIA[:AXIS][1], #siwka add test
                            message: "value should be in range #{CRITERIA[:AXIS][0]}..#{CRITERIA[:AXIS][1]}" },
                            presence: true,
                            numericality: { only_integer: true }
  end

  with_options if: :re_is_axis? do |presc|
    presc.validates_inclusion_of :re_indicator_extra, in: %w(CYL),
    												message: "with right eye AXIS only CYL is valid"
    presc.validates :re_value_extra, inclusion: { in: CRITERIA[:CYL][0]..CRITERIA[:CYL][1], #siwka add test
                            message: "value should be in range -10..-0.25" },
                            presence: true,
                            numericality: true
  end

  with_options if: :le_is_cyl? do |presc|
    presc.validates_inclusion_of :le_indicator_extra, in: %w(AXIS),
    												message: "with left eye CYL only AXIS is valid"
    presc.validates :le_value_extra, presence: true, numericality: { only_integer: true }
  end

  with_options if: :le_is_axis? do |presc|
    presc.validates_inclusion_of :le_indicator_extra, in: %w(CYL),
    												message: "with left eye AXIS only CYL is valid"
    presc.validates :le_value_extra, presence: true,
                                     numericality: true
  end

  with_options unless: :re_cyl_or_axis? do |presc|
    presc.validates :re_indicator_extra, inclusion: { in: [''] }
    presc.validates :re_value_extra, inclusion: { in: [nil] }
  end    

  with_options unless: :le_cyl_or_axis? do |presc|
    presc.validates :le_indicator_extra, inclusion: { in: [''] }
    presc.validates :le_value_extra, inclusion: { in: [nil] }
  end 

  private

  	def re_is_cyl?
  		self.re_indicator == 'CYL'
  	end

  	def le_is_cyl?
  		self.le_indicator == 'CYL'
  	end

  	def re_is_axis?
  		self.re_indicator == 'AXIS'
  	end

  	def le_is_axis?
  		self.le_indicator == 'AXIS'
  	end

  	def re_cyl_or_axis?
  		re_is_cyl? || re_is_axis?
  	end 

  	def le_cyl_or_axis?
  		le_is_cyl? || le_is_axis?
  	end   	

  	def contacts?
  		!self.glasses
  	end
end
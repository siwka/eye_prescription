class Prescription < ActiveRecord::Base
  belongs_to :user#, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :glasses, presence: true
  validates :re_indicator, presence: true#,
                           # inclusion: { in: CRITERIA_CODES.keys.map(&:to_s) }   #siwka
  validates :re_value, presence: true, numericality: true
  validates :le_indicator, presence: true
  validates :le_value, presence: true, numericality: true

  with_options if: :glasses do |presc|
    presc.validates :re_indicator, exclusion: { in: %w(BC DIAM),
    												message: "%{value} present only for contact lens prescription" }
  end

  with_options if: :glasses do |presc|
    presc.validates :le_indicator, exclusion: { in: %w(BC DIAM),
    												message: "%{value} present only for contact lens prescription" }
  end  

  with_options if: :re_is_cyl? do |presc|
    presc.validates :re_indicator_extra, presence: true, inclusion: { in: %w(AXIS),
    																				message: "with CYL only %{value} is valid"  }
    presc.validates :re_value_extra, presence: true, numericality: { only_integer: true }
  end

  with_options if: :re_is_axis? do |presc|
    presc.validates :re_indicator_extra, presence: true, inclusion: { in: %w(CYL),
    																				message: "with AXIS only %{value} is valid"  }
    presc.validates :re_value_extra, presence: true, numericality: true
  end

  with_options unless: :re_cyl_or_axis? do |presc|
    presc.validates :re_indicator_extra, inclusion: { in: [nil] }
    presc.validates :re_value_extra, inclusion: { in: [nil] }
  end 

  with_options if: :le_is_cyl? do |presc|
    presc.validates :le_indicator_extra, presence: true, inclusion: { in: %w(AXIS),
    																				message: "with CYL only %{value} is valid"  }
    presc.validates :le_value_extra, presence: true, numericality: { only_integer: true }
  end

  with_options if: :le_is_axis? do |presc|
    presc.validates :le_indicator_extra, presence: true, inclusion: { in: %w(CYL),
    																				message: "with AXIS only %{value} is valid"  }
    presc.validates :le_value_extra, presence: true, numericality: true
  end  

  with_options unless: :le_cyl_or_axis? do |presc|
    presc.validates :le_indicator_extra, inclusion: { in: [nil] }
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
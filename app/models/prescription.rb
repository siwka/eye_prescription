class Prescription < ActiveRecord::Base
  belongs_to :user#, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates_inclusion_of :glasses, in: [true, false] # add test view works
  validates_inclusion_of :re_indicator, :le_indicator,
                           in: CRITERIA.keys.map(&:to_s),
                           message: "should be any of %w(:SPH :CYL :AXIS :BC :DIAM)"
  validates :re_value, :le_value, presence: true, numericality: true

  with_options if: :re_is_sph? do |presc|
    presc.validates :re_value, inclusion: { in: HASH[:SPH],
                            message: "value should be in range #{CRITERIA[:SPH][0]} .. #{CRITERIA[:SPH][1]}" },
                            presence: true
  end  

  with_options if: :le_is_sph? do |presc|
    presc.validates :le_value, inclusion: { in: HASH[:SPH],
                            message: "value should be in range #{CRITERIA[:SPH][0]} .. #{CRITERIA[:SPH][1]}" },
                            presence: true
  end

  with_options if: :re_is_bc? do |presc|
    presc.validates :re_value, inclusion: { in: HASH[:BC],
                            message: "value should be in range #{CRITERIA[:BC][0]} .. #{CRITERIA[:BC][1]}" },
                            presence: true
  end  

  with_options if: :le_is_bc? do |presc|
    presc.validates :le_value, inclusion: { in: HASH[:BC],
                            message: "value should be in range #{CRITERIA[:BC][0]} .. #{CRITERIA[:BC][1]}" },
                            presence: true
  end

  with_options if: :re_is_diam? do |presc|
    presc.validates :re_value, inclusion: { in: HASH[:DIAM],
                            message: "value should be in range #{CRITERIA[:DIAM][0]} .. #{CRITERIA[:DIAM][1]}" },
                            presence: true
  end  

  with_options if: :le_is_diam? do |presc|
    presc.validates :le_value, inclusion: { in: HASH[:DIAM],
                            message: "value should be in range #{CRITERIA[:DIAM][0]} .. #{CRITERIA[:DIAM][1]}" },
                            presence: true
  end    

  with_options if: :glasses do |presc|
    presc.validates :re_indicator, exclusion: { in: %w(BC DIAM),
                            message: "%{value} present only for contact lens prescription" }
    presc.validates :le_indicator, exclusion: { in: %w(BC DIAM),
                            message: "%{value} present only for contact lens prescription" }
  end   

  with_options if: :re_is_cyl? do |presc|
    presc.validates :re_value, inclusion: { in: HASH[:CYL],
                            message: "value should be in range #{CRITERIA[:CYL][0]} .. #{CRITERIA[:CYL][1]}" },
                            presence: true,
                            numericality: true
    presc.validates_inclusion_of :re_indicator_extra, in: %w(AXIS),
    												message: "with right eye CYL only AXIS is valid"
    presc.validates :re_value_extra, inclusion: { in: HASH[:AXIS], #siwka add test
                            message: "value should be in range #{CRITERIA[:AXIS][0]} .. #{CRITERIA[:AXIS][1]}" },
                            presence: true,
                            numericality: { only_integer: true }
  end

  with_options if: :re_is_axis? do |presc|
    presc.validates :re_value, inclusion: { in: HASH[:AXIS],
                            message: "value should be in range #{CRITERIA[:AXIS][0]} .. #{CRITERIA[:AXIS][1]}" },
                            presence: true,
                            numericality: { only_integer: true }    
    presc.validates_inclusion_of :re_indicator_extra, in: %w(CYL),
    												message: "with right eye AXIS only CYL is valid"
    presc.validates :re_value_extra, inclusion: { in: HASH[:CYL],
                            message: "value should be in range #{CRITERIA[:CYL][0]} .. #{CRITERIA[:CYL][1]}" },
                            presence: true,
                            numericality: true
  end

  with_options if: :le_is_cyl? do |presc|
    presc.validates :le_value, inclusion: { in: HASH[:CYL],
                            message: "value should be in range #{CRITERIA[:CYL][0]} .. #{CRITERIA[:CYL][1]}" },
                            presence: true,
                            numericality: true    
    presc.validates_inclusion_of :le_indicator_extra, in: %w(AXIS),
    												message: "with left eye CYL only AXIS is valid"
    presc.validates :le_value_extra, inclusion: { in: HASH[:AXIS],
                            message: "value should be in range #{CRITERIA[:AXIS][0]} .. #{CRITERIA[:AXIS][1]}" },
                            presence: true,
                            numericality: { only_integer: true }
  end

  with_options if: :le_is_axis? do |presc|
    presc.validates :le_value, inclusion: { in: HASH[:AXIS],
                            message: "value should be in range #{CRITERIA[:AXIS][0]} .. #{CRITERIA[:AXIS][1]}" },
                            presence: true,
                            numericality: { only_integer: true }    
    presc.validates_inclusion_of :le_indicator_extra, in: %w(CYL),
    												message: "with left eye AXIS only CYL is valid"
    presc.validates :le_value_extra, inclusion: { in: HASH[:CYL],
                            message: "value should be in range #{CRITERIA[:CYL][0]} .. #{CRITERIA[:CYL][1]}" },
                            presence: true,
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

    def re_is_sph?
      self.re_indicator == 'SPH'
    end

    def le_is_sph?
      self.le_indicator == 'SPH'
    end

    def re_is_bc?
      self.re_indicator == 'BC'
    end

    def le_is_bc?
      self.le_indicator == 'BC'
    end

    def re_is_diam?
      self.re_indicator == 'DIAM'
    end

    def le_is_diam?
      self.le_indicator == 'DIAM'
    end    

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
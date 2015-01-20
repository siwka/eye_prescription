# CRITERIA = %w(SPH CYL AXIS BC DIAM)
	                     # min, max, increments
	CRITERIA = { :SPH =>  [-10,  10,    0.25],
               :CYL =>  [-10,  -0.25, 0.25],
               :AXIS => [  0, 180,    1],
               :BC =>   [  7,   9,    0.1],
               :DIAM => [ 13,  15,    0.1] }
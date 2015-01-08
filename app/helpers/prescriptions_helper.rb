module PrescriptionsHelper
	                        # min, max, increments
	CRITERIA_CODES = { sph: [-10,  10,    0.25],
		                cyl:  [-10,  -0.25, 0.25],
		                axis: [  0, 180,    1],
		                bc:   [  7,   9,    0.1],
		                diam: [ 13,  15,    0.1] }
end

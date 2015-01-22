	                     # min, max, increments
	CRITERIA = { :SPH  => [-10,  10,    0.25],
               :CYL  => [-10,  -0.25, 0.25],
               :AXIS => [  0, 180,    1],
               :BC   => [  7,   9,    0.10],
               :DIAM => [ 13,  15,    0.10] }

def mk_arr(key)
	arr = []
  n = CRITERIA[key][0]
  begin
  	arr << n
  	n += CRITERIA[key][2]
  	n = n.round(1) if (key == :DIAM || key == :BC)
  end while n <= CRITERIA[key][1]
  arr
end

HASH = CRITERIA.keys.map.each_with_object({ }) { |k, h| h[k] = mk_arr(k) }

# or make class?   -siwka
# CRITERIA.keys.map(&:to_s).each do |key|
# 	self.instance_variable_set(('@' + key.downcase).intern, mk_arr(key))
# end
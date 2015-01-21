User.create!(name:  "Eyeuser",
             email: "eye@example.com",
             password:              "zoofoobar",
             password_confirmation: "zoofoobar")

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = "password"
  User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password)
end


criteria = %w(SPH CYL AXIS BC DIAM)
# criteria = %w(SPH LYC SIXA CB MAID)

users = User.order(:created_at).take(6)
19.times do
  content = Faker::Lorem.sentence(5)
  users.each do |user| 
  	user.prescriptions.create!( glasses: true,
															  re_indicator: criteria.sample,
															  re_value: rand(-10..10),
															  le_indicator: criteria.sample,
															  le_value: rand(-10..10),
															  re_indicator_extra: nil,
															  re_value_extra: nil,
															  le_indicator_extra: nil,
															  le_value_extra: nil)
  end	
end
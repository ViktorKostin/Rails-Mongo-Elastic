def create(email, pass)
	User.create({:email => email, :password => pass, :password_confirmation => pass})
	puts "email: " + email + " pass: " + pass
end
create("admin@mail.com", "admin1")
10.times do |x|
	x += 1
	email = "user" + x.to_s + "@mail.com"
	pass = "123456"
create(email, pass)
end
puts 'Users was successfully created'
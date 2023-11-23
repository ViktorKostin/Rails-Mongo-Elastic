def create(email, pass, rights = "user")
	User.create({:email => email, :password => pass, :password_confirmation => pass, :rights => rights})
	puts "email: #{email} pass: #{pass} rights: #{rights}"
end

create("admin@mail.com", "admin1", "admin")

10.times do |x|
	x += 1
	email = "user" + x.to_s + "@mail.com"
	pass = "123456"
create(email, pass)
end

puts 'Users was successfully created'
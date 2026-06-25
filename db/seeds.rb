# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

def creating(category)
  puts "creating #{category}"
end

puts "Creating roles"
user_role = Role.find_or_create_by(code:"usr") {|r| r.name ="User"}
admin_role = Role.find_or_create_by(code:"adm") {|r| r.name ="Administrator"}

puts "Roles seeded:"
Role.all.each {|r| puts "#{r.code}- #{r.name}"}


# Seeding admin
puts "Creating admin"
admin = User.find_or_create_by!(
  email: "admin@example.com"
)do |user|
  user.firstname = "System"
  user.lastname = "Admin"
  user.password = "password123"
  user.password_confirmation = "password123"
  user.role = admin_role
end

# regular user (client)

5.times do |i|
  User.find_or_create_by!(
    email: "user#{i+1}@exmaple.com"
  ) do |user|
    user.firstname = "user"
    user.lastname = "#{i+1}"
    user.password = "user_password_#{i+1}"
    user.password_confirmation = "userpassword#{i+1}"
    user.role = user_role
  end
end

#Contacts
User.where(role: user_role).find_each do |user|
  5.times do |i|
    Contact.find_or_create_by!(
      user: user,
      phone_number: "024000000#{i}"
    )do |contact|
      contact.firstname = "Contact"
      contact.lastname = "#{i+1}"
      contact.category = "Uncategorised"
    end
  end
end

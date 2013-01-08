puts 'CREATING ROLES'
Role.create([
                { :name => 'admin' },
                { :name => 'vip' },
                { :name => 'user' },
                { :name => 'disabled' }
            ], :without_protection => true)


puts 'SETTING UP DEFAULT USER LOGIN'
user1 = User.create! :firstname => 'Admin',:lastname => 'User', :email => 'admin@example.com', :password => 'hello2013', :password_confirmation => 'hello2013'
puts 'New user created: ' << user1.fullname
user1.add_role :admin





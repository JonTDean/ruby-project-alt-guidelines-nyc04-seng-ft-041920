def who_are_you?
    puts "What is your name?"
    username = gets.chomp
    
    if !User.all.include?(username)
        puts "Hello #{username}"
    else
        Puts "User Not Found, Do you want to create a new user?"
        new_user_response = gets.chomp
        if new_user_response == y
            puts "What is your password?"
            password = gets.chomp
            User.create(username, password)
        elsif new_user_response == n 
            return "Ok GoodBye."
        end
    end
end


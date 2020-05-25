require 'bcrypt' # Had to run 'gem pristine bcrypt' in order for it to run

class UserPassword
    attr_accessor :hashed_password
    private :hashed_password, :hashed_password=

    include BCrypt
    # attr_reader :password_digest


    # Password - Method Handler for Password Creation
    def self.create_password
        puts "What do you want your password to be? Numbers and Letters only (Case-Sensitive!)."
        new_user_password = STDIN.gets.chomp                                            # Rake doesn't receive 'gets' only STDIN

        # Takes the given password and performs a check
        self.create_password_complexity_check(new_user_password)
    end

    # Check to see if password is correct for user sign in
    def self.check_password(given_password, user_object)
        if BCrypt::Password.new(user_object.password) == given_password    # Compares Hash salts to user input for password
            # puts "SUCCESS"
            true
        else 
            # puts "FAIL"
            false
        end

    end

    private
    # Password Helper Methods:


    # Checks for correct password
    def self.create_password_complexity_check(password)
        case password                               
        when /^[0-9a-zA-Z]*$/                                                           # Tight check for Numbers and Letters
            BCrypt::Password.create(password)                                           # Creates a Hash of the stored password 
        else
            self.reverify_password(password)                                            # Forces Password Check 
        end
    end

    # Password - Forces correct password complexity
    def self.reverify_password(password)
        while !password.match(/^[0-9a-zA-Z]*$/)                      # Tight check for Numbers and Letters
            puts "You have entered an illegal character! Please put a number or a letter (Case-Sensitive!), No Spaces!"
            password = STDIN.gets.chomp
        end
        password
    end
end
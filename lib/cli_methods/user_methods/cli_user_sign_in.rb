require_relative '../../models/user'                        # This gave me so many errors - Jon https://stackoverflow.com/questions/24614566/how-to-navigate-two-directories-up-ruby
require_relative './cli_user_sign_up'

class SignIn
    attr_reader :current_user, :is_user
    private :is_user


    def self.log_in?(username)      
        # If name is in database then prompt for password else prompt for create an account
        
        if User.exists?(name: username)                     # Checks to see if the User Exists 
            @current_user = User.find_by(name: username)    # Grabs user object

            # Debug.user_object_check(current_user, current_user.id, current_user.name, current_user.password)
            @is_user = self.ask_for_password                # Bring up User Password Prompt
            log_in                                          # Attempt Login
        else
            UserAccountCreation.ask_user_create?            # Goes to Account Creation
        end
    end


    private 

    # Assigns CLI_User a user object table
    def self.log_in
        if @is_user
            CLIUser.log_in_to_account(@current_user)
        end
    end

    # Asks for Password then does comparison check for simple Authorization
    def self.ask_for_password
        puts "What is your Password (Case-Sensitive!)."
        self.get_password
    end

    # Grabs password then performs a check
    def self.get_password
        password_input = STDIN.gets.chomp
        if  UserPassword.check_password(password_input, @current_user)                  # Checks if user password is correct
            # puts "Correct Password!"
            true
        else
            while UserPassword.check_password(password_input, @current_user) == false   # If user password is incorrect then the
                puts "please put the correct password!"
                password_input = STDIN.gets.chomp
            end
            # puts "Correct Password!"
            true
        end
                
    end

    # Custom Debug class to verify proper User variables
    class Debug 
        def self.user_object_check(object, id, name, password)
            puts "===============DEBUG==============="
            puts "The User Object is: #{object}"
            puts "The ID is: #{id}"
            puts "The name is: #{name}"
            puts "The password is: #{password}"
            puts "===============DEBUG==============="
        end
    end
end

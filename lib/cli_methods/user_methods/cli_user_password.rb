require 'bcrypt' # Had to run 'gem pristine bcrypt' in order for it to run
require_relative '../../models/cli'

class UserPassword
    
    include BCrypt

    # Password - Method Handler for Password Creation
    def self.create_password
        is_valid =  "You have entered an illegal character! Please put a number or a letter (Case-Sensitive!), No Spaces!"

        # Asks user for password
        new_user_password = CLI.prompts.ask("What do you want your password to be? Numbers and Letters only (Case-Sensitive!).") do |q|
            q.required true                                                 # Requires Special Properties defined at <q>
            q.validate /^[0-9a-zA-Z]*$/                                     # Performs comparison check, if true validate is true if false validate is false
            q.messages[:valid?] = is_valid                                  # Set custom <valid?> Property https://www.rubydoc.info/gems/tty-prompt/TTY%2FPrompt%2Emessages
        end

        self.secure_password(new_user_password)
    end

    # Check to see if password is correct for user sign in
    def self.check_password(given_password, user_object)
        if BCrypt::Password.new(user_object.password) == given_password    # Compares Hash salts to user input for password
            true                                                           # Confirms Correct Password 
        else
            false                                                          # Confirms False Password
        end
    end

    # Update Account Password
    def self.update_check(given_password)
        if BCrypt::Password.new( CLIUserController.current_user?.password) == given_password    # Compares Hash salts to user input for password
            CLI.prompts.say("Password Authenticated")     
            true                                                               # Confirms Correct Password 
        else
            CLI.prompts.say("Incorrect Password")
            CLIUserController.update_account_start(given_password)                                                                               # Confirms False Password
        end
    end

    #  Hashes password
    def self.secure_password(password)
        BCrypt::Password.create(password)                                  # Creates a Hash of the stored password 
    end
end
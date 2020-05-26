require 'bcrypt' # Had to run 'gem pristine bcrypt' in order for it to run
require_relative '../../models/Interface'

class UserPassword
    
    include BCrypt

    # Password - Method Handler for Password Creation
    def self.create_password
        is_valid =  "You have entered an illegal character! Please put a number or a letter (Case-Sensitive!), No Spaces!"

        # Asks user for password
        new_user_password = @cli.prompt.ask("What do you want your password to be? Numbers and Letters only (Case-Sensitive!).") do |q|
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

    private
    @cli = Interface.new
    
    # Checks for correct password
    def self.secure_password(password)
        BCrypt::Password.create(password)                                  # Creates a Hash of the stored password 
    end
end
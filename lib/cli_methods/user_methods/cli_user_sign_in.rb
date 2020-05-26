require_relative '../../models/user'                        # This gave me so many errors - Jon https://stackoverflow.com/questions/24614566/how-to-navigate-two-directories-up-ruby
require_relative './cli_user_sign_up'

class SignIn
    attr_reader :is_user, :cli, :is_valid
    private :is_user, :is_valid

    def self.log_in?(username)      
        # If name is in database then prompt for password else prompt for create an account
        if User.exists?(name: username)                     # Checks to see if the User Exists 
            @current_user = User.find_by(name: username)    # Grabs user object
            # # Custom Debug class to look at User variables goes here
            @is_user = self.ask_for_password                # Bring up User Password Prompt
            self.set_user_state                             # Attempt Login
        else
            UserAccountCreation.ask_user_create?            # Goes to Account Creation
        end
    end

    private 
    @cli = CLI.new                                                    # Sets CLI interface to only be used via this class
    @is_valid = "Letters and Numbers Only!"                                             # Container for local class variable, need to delete after refactor

    # Assigns CLIUser a user object
    def self.set_user_state
        if @is_user
            CLIUserController.log_in_to_account(@current_user)
        else
            puts "User Account Error"                                                   # Error Shouldn't occur but just in case
        end
    end

    # Asks for Password then does comparison check for simple Authorization
    def self.ask_for_password
        password = @cli.prompt.mask("What is your password") do |q|
            q.required true                                                             # Requires Special Properties defined at <q>
            q.validate /^[0-9a-zA-Z]*$/                                                 # Performs comparison check, if true validate is true if false validate is false
            q.messages[:valid?] = @is_valid                                             # Set custom <valid?> Property https://www.rubydoc.info/gems/tty-prompt/TTY%2FPrompt%2Emessages
        end

        self.password_check(password)
    end

    # Grabs password then performs a check
    def self.password_check(typed_password)
        if  UserPassword.check_password(typed_password, @current_user)                 # Checks if user password is correct
            true
        else                                                                            # If user password is incorrect then ask for password recursively.
            password = @cli.prompt.mask("Please Enter The correct Password.") do |q|
                q.required true                                                         # Requires Special Properties defined at <q>
                q.validate /^[0-9a-zA-Z]*$/                                             # Performs comparison check, if true validate is true if false validate is false
                q.messages[:valid?] = @is_valid                                         # Set custom <valid?> Property https://www.rubydoc.info/gems/tty-prompt/TTY%2FPrompt%2Emessages
            end
            self.password_check(password)
        end          
    end

end

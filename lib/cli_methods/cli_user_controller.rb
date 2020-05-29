require_relative './user_methods/cli_user_sign_in'
require_relative '../models/cli'
require 'io/console'


class CLIUserController 
    @@current_user = nil                            

    # Passes Current User Object
    def self.current_user?
        @@current_user                              
    end

    # For logging out
    def self.log_out?
        choice = CLI.prompts.select("Are you sure you want to log out?", ["Yes", "No"])
        case choice
        when "Yes"
            CLI.prompts.say("Logging out...")
            sleep(0.7)
            system "clear"
            @@current_user = nil                    # Sets User "Logged In" state to off, current_user == nil
            CLIController.welcome_screen            # Goes back to start menu
        when "No"
            CLIController.user_portal               # Goes back to the User Portal Menu
        end
    end
    
    # Passes Current User ID
    def self.my_id?
        @@current_user.id         # Displays ID of current User Object               
    end

    # Passes Current User Name
    def self.my_name?                               
        @@current_user.name       # Displays Name of current User Object
    end
    
    # logs user into account
    def self.log_in_to_account(logged_in_user)  
        @@current_user = logged_in_user 
        sleep(0.5)
        system "clear"
        sleep(0.5)
        message = CLIStyle.cake("Welcome ")
        user = CLIStyle.colors("#{CLIUserController.my_name?}", "#d741a7")
        CLI.prompts.say(message + user)             # Sets State to Logged In
        CLIController.user_portal
        # DeanbugMenu.who_is?(@@current_user)        # Displays User Screen ## DEBUG 
    end

    # Deletes Account
    def self.delete_account
        @@current_user.delete_account
    end

    # Update Account 
    def self.update_account_menu
        property = CLI.prompts.select("What Setting would you like to update?", [:name, :password])
        self.update_account_start(property)
    end

    # Performs Edit of Table on user that is logged in
    def self.update_account_start(property)
        case property
        when :password
            current_password = CLI.prompts.ask("What is your current password #{property}?") do |q|        # Prompts for Password
                q.required true                                                                  # Requires Special Properties defined at <q>
                q.validate /^[0-9a-zA-Z]*$/                                                      # Performs comparison check, if true validate is true if false validate is false
                q.messages[:valid?] = "Please use Letters(Uppercase or Lowercase) and numbers"   # Set custom <valid?> Property https://www.rubydoc.info/gems/tty-prompt/TTY%2FPrompt%2Emessages
            end

            UserPassword.update_check(current_password) # Checks Password for Correct Authetication
            change = UserPassword.create_password               # Creates the New Password and hashes it
            @@current_user.update(property => change)   # Modifies the current user's information
        when :name
            CLI.prompts.say("Current Name is: #{CLIUserController.my_name?}")
            change = CLI.prompts.ask("What do you want to change #{property} to?") do |q|        # Prompts for User Name
                q.required true                                                                  # Requires Special Properties defined at <q>
                q.validate /^[a-zA-Z]*$/                                                         # Performs comparison check, if true validate is true if false validate is false
                q.messages[:valid?] = "Please use Letters(Uppercase or Lowercase)"               # Set custom <valid?> Property https://www.rubydoc.info/gems/tty-prompt/TTY%2FPrompt%2Emessages
            end

            ## Sets user to <Var :: change>
            @@current_user.update(property => change) # Modifies the current user's information
        end
                 
        CLI.prompts.say("Account has been updated successfully.")
        sleep(0.5)
        CLIController.profile_options_menu                                                       # 
    end 
    
end


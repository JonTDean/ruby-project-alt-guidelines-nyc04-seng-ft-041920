require_relative '../../models/user'
require_relative '../../models/cli'

class UserAccountCreation

    def initialize 
        self.ask_user_create?
    end

    #Ask to initate user account creation
    def self.ask_user_create?
        sleep(0.5)
        ask_user = CLIStyle.colors("You don't have an account with us! Would you like to create an account? Enter Yes, No, or Quit App?", "#f18805")
        answer = CLI.prompts.select(ask_user, CLIHelper.y_n_e)    # Prompts user for account creation

        # Checks Answer to proceed to the next step
        sleep(0.5)
        self.yes_or_no?(answer)
    end

    private
    # Yes or No Event handler
    def self.yes_or_no?(answer)
        case answer
        when /Yes/                                               # if "Yes" goes to account creation
            system "clear"
            self.account_creation 
        when /No/                                                # Else if "No" Will take you back to the Main Menu."
            system "clear"
            CLIController.start_screen
        when /Quit/
            system "clear"
            CLI.close
        end
    end

    # Account Creation Handler
    def self.account_creation
        new_user_name = self.create_username                     # Creates Username
        password = UserPassword.create_password                  # Creates Password

        self.account_to_table(new_user_name, password)           # Saves Account to table
    end

    # Username Helper Methods:
    
    # Username - Method Handler for Username Creation
    def self.create_username
        # Outside of CLI.prompts.ask because it hits the edge of the cli
        message = CLIStyle.colors("Lets Create an Account! In the following menus, enter what do you want your name to be, and what you want your password to be?", "#f18805")
        CLI.prompts.say(message)
        new_user_name =  CLI.prompts.ask("What is your name? Letters only: ") do |q|                # Prompts for User Name
            q.required true                                                                         # Requires Special Properties defined at <q>
            q.validate /^[a-zA-Z\s]*$/                                                              # Performs comparison check, if true validate is true if false validate is false
            q.messages[:valid?] = "Please use Letters(Uppercase or Lowercase). Spaces Allowed"      # Set custom <valid?> Property https://www.rubydoc.info/gems/tty-prompt/TTY%2FPrompt%2Emessages
        end


        while User.find_by(name: new_user_name)
            new_user_name =  CLI.prompts.ask("Account Already Exists, please enter a new account ") do |q|    # Prompts for Unique User Name
                q.required true                                                             # Requires Special Properties defined at <q>
                q.validate /^[a-zA-Z]*$/                                                    # Performs comparison check, if true validate is true if false validate is false
                q.messages[:valid?] = "Please use Letters(Uppercase or Lowercase)"          # Set custom <valid?> Property https://www.rubydoc.info/gems/tty-prompt/TTY%2FPrompt%2Emessages
            end
        end
        new_user_name
    end
    
    # Saves Account to table then goes to login menu
    def self.account_to_table(user_name, password)
        sleep(0.25)
        puts "Account Created! Going to Main Menu..."
        sleep(0.5)
        new_user = User.create(name: user_name, password: password)         # Saves User to user.db
        CLIUserController.log_in_to_account(new_user)                       # Goes back to User Portal                                 
    end
    
end
require_relative '../../models/user'
require_relative '../../models/cli'

class UserAccountCreation
    @cli = CLI.new

    def initialize 
        self.ask_user_create?
    end

    #Ask to initate user account creation
    def self.ask_user_create?
        ask_user = "You don't have an account with us! Would you like to create an account? Enter Yes(Create Account), No(Go back to Main Menu), or Quit(Exit Program)."
        answer = @cli.prompt.select(ask_user, CLIHelper.y_n) # Prompts user for account creation

        # Checks Answer to proceed to the next step
        self.yes_or_no?(answer)
    end

    private
    # Yes or No Event handler
    def self.yes_or_no?(answer)
        case answer
        when /Yes/                                          # if "Yes" goes to account creation
            self.account_creation 
        when /No/                                           # Else if "No" Will take you back to the Main Menu."
            CLI.back_to_log_in_menu
        when /Quit/
            abort("Goodbye!")
        end
    end

    # Account Creation Handler
    def self.account_creation
        new_user_name = self.create_username                     # Creates Username
        password = UserPassword.create_password                  # Creates Password

        # Delete DeanbugMenu after setting up actual menu
        DeanbugMenu.correct_settings(new_user_name, password)

        self.account_to_table(new_user_name, password)           # Saves Account to table
    end

    # Username Helper Methods:
    
    # Username - Method Handler for Username Creation
    def self.create_username
        # Outside of cli.prompt.ask because it hits the edge of the cli
        puts "==========================================================================================================================="
        puts "Lets Create an Account! In the following menus, enter what you want your name to be, and what you want your password to be!" 
        puts "==========================================================================================================================="
        new_user_name =  @cli.prompt.ask("What is your name? Letters only: ") do |q|    # Prompts for User Name
            q.required true                                                             # Requires Special Properties defined at <q>
            q.validate /^[a-zA-Z]*$/                                                    # Performs comparison check, if true validate is true if false validate is false
            q.messages[:valid?] = "Please use Letters(Uppercase or Lowercase)"          # Set custom <valid?> Property https://www.rubydoc.info/gems/tty-prompt/TTY%2FPrompt%2Emessages
        end
        
        new_user_name
    end
    
    # Saves Account to table then goes to login menu
    def self.account_to_table(user_name, password)
        puts "Account Created! Going back to main menu."
        User.create(name: user_name, password: password)        # Saves User to user.db
        CLI.back_to_log_in_menu                                 # Goes back to main menu
    end
    
end
require_relative '../../models/user'

class UserAccountCreation
    
    #Ask to initate user account
    def self.ask_user_create?
        puts "You don't have an account with us! Would you like to create an account? Enter Yes[y] or No [n]."
        answer = STDIN.gets.chomp.downcase
        self.yes_or_no?(answer)
    end

    private
    # Yes or No handler
    def self.yes_or_no?(answer)
        case answer
        when /yes|y/                                # Checks input for "y", "yes"
            self.account_creation 
        when /n|no/                                 # Checks input for "n", "no (Will take you back to the Main Menu."
            puts "Heading Back to the Main Menu..."
            CLIUser.start
            # abort( "Exiting Program.... Goodbye!")
        else
            self.force_yes_or_no_check(answer)
        end
    end

    def self.force_yes_or_no_check(answer)
        while !answer.match(/n|no|y|yes/)           # Checks input for "n", "no", "y", "yes"
            puts "Invalid Response! type either Y or N"
            answer = STDIN.gets.chomp.downcase
        end
        self.yes_or_no?(answer)                     # Returns Verified answer
    end

    # Account Creation Handler
    def self.account_creation

        new_user_name = self.create_username
        password = UserPassword.create_password

        # puts "+++++++++++++++++DEBUG++++++++++++++++++++++++"
        # puts new_user_name
        # puts password
        # puts "++++++++++++++++++++++++++++++++++++++++++++++"

        User.create(name: new_user_name, password: password)
    end

    # Username Helper Methods:
    
    #  Username - Method Handler for Username Creation
    def self.create_username
        puts "Lets Create an Account! In the following menus, enter what you want your name to be, and what you want your password to be!"
        puts "What is your name? Letters only, no Synths Allowed!"

        new_user_name = STDIN.gets.chomp.downcase   # Rake doesn't receive 'gets' only STDIN
    
        self.username_complexity_check(new_user_name)
    end

    # Username - Initiates Username Check
    def self.username_complexity_check(username)
        case username
        when /^[a-zA-Z \s]*$/                       # Tight check for Spaces and Letters
            username                                # Returns Username if check passes  
        else                                        # Forces Username Check
            self.reverify_username(username)
        end
    end
    
    # Username - Forces correct username complexity
    def self.reverify_username(username)
        while !username.match(/^[a-zA-Z \s]*$/)     # Allows for Firstname, Middlename, Etc.
            puts "You have entered an illegal character! Please put an upper or lower case letter."
            username = STDIN.gets.chomp
        end
        username
    end

 
end
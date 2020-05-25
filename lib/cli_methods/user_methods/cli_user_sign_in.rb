require_relative '../../models/user'    # This gave me so many errors - Jon https://stackoverflow.com/questions/24614566/how-to-navigate-two-directories-up-ruby

class UserSignIn

    attr_accessor :name
    private :name=

    def initialize
        get_name
        Puts "Welcome!"
        
    end

    def self.get_name
        puts "Hi! Please tell me your name!"
        @name = STDIN.gets.chomp    # Rake doesn't receive gets only STDIN, fixed for now; https://stackoverflow.com/questions/19087611/accepting-user-input-from-the-console-command-prompt-inside-a-rake-task/19087705
        self.name_check(@name)
    end
    
    # If name is in database then prompt for password else prompt for create an account
    def self.name_check(name)       # See if I can private method
        if User.exists?(name: name) # Checks to see if the User Exists 
            ask_for_password        #
        else
            account_creation
        end
    end

    def ask_for_password
        puts "template ask_for_password"
    end

    # Delete After
    def account_creation
        puts "template for account_creation"
    end


end

# paco = Cli_User.new
# Cli_User.get_name
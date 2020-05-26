require_relative './user_methods/cli_user_sign_in'
require 'io/console'


class CLIUser
    attr_accessor :name, :current_user
    private :name=, :current_user=                  # Found technique to use private with symbols
                                                    # https://stackoverflow.com/questions/25571642/ruby-private-and-public-accessors

    # Starts new CLIUser State Management Instance
    def initialize
        CLIUser.start
    end
    
    # Begins Sign In / Sign Up process
    def self.start 
        puts "Hi! Please tell me your name!"
        @name = STDIN.gets.chomp                    # Rake doesn't receive 'gets' only STDIN, fixed for now; https://stackoverflow.com/questions/19087611/accepting-user-input-from-the-console-command-prompt-inside-a-rake-task/19087705
        SignIn.log_in?(@name)
    end

    # logs user into account
    def self.log_in_to_account(logged_in_user)  
        @current_user = logged_in_user              # Sets State to Logged In
        DeanbugMenu.who_is?(@current_user)          # Displays User Screen ## DEBUG 
    end
    
end


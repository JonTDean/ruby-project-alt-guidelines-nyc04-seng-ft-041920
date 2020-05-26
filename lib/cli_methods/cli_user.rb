require_relative './user_methods/cli_user_sign_in'
require_relative '../models/Interface'
require 'io/console'


class CLIUser
    attr_accessor :current_user, :cli 
    private :current_user=, :cli=                   # Found technique to use private with symbols
                                                    # https://stackoverflow.com/questions/25571642/ruby-private-and-public-accessors

    # Starts new CLIUser State Management Instance
    def initialize    
        @cli = Interface.new
        name = @cli.prompt.ask("Hi! Please tell me your name!")
        SignIn.log_in?(name)                        # Begins Sign In / Sign Up process
    end
    
    # logs user into account
    def self.log_in_to_account(logged_in_user)  
        @current_user = logged_in_user              # Sets State to Logged In
        DeanbugMenu.who_is?(@current_user)          # Displays User Screen ## DEBUG 
    end
    
end


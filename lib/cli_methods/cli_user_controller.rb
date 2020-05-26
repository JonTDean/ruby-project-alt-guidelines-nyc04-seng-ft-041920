require_relative './user_methods/cli_user_sign_in'
require_relative '../models/cli'
require 'io/console'


class CLIUserController 
    attr_accessor :cli                              # Found technique to use private with symbols
    private :cli=                                   # https://stackoverflow.com/questions/25571642/ruby-private-and-public-accessors
    @@current_user = nil                            

    # Starts new CLIUser State Management Instance
    def initialize
        name =  CLI.prompts.ask("Hi! Please tell me your name!")
        SignIn.log_in?(name)                        # Begins Sign In / Sign Up process
    end

    def self.current_user?
        @@current_user                              # Passes Current User Object
    end
    
    def self.my_id?
        @@current_user.id                           # Passes Current User ID
    end

    def self.my_name?                               # Passes Current User Name
        @@current_user.name
    end
    
    # logs user into account
    def self.log_in_to_account(logged_in_user)  
        @@current_user = logged_in_user              # Sets State to Logged In
        ## USERPORTAL GOES HERE
        DeanbugMenu.who_is?(@@current_user)          # Displays User Screen ## DEBUG 
    end
    
end


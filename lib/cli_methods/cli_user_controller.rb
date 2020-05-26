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

    # Passes Current User Object
    def self.current_user?
        @@current_user                              
    end
    
    # Passes Current User ID
    def self.my_id?
        @@current_user.id                           
    end

    # Passes Current User Name
    def self.my_name?                               
        @@current_user.name
    end
    
    # logs user into account
    def self.log_in_to_account(logged_in_user)  
        @@current_user = logged_in_user              # Sets State to Logged In
        ## USERPORTAL GOES HERE
        DeanbugMenu.who_is?(@@current_user)          # Displays User Screen ## DEBUG 
    end

    # Deletes Account
    def self.delete_account
        @@current_user.delete_account
    end

    # Update Account 
    # def update_account_menu
    
    # end

    # def update_account_start(property)
    #     @@current_user.update()
    # end
    
end


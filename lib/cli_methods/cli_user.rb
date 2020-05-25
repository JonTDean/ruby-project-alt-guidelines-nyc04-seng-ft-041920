require_relative './user_methods/cli_user_sign_in'

class CLIUser
    attr_accessor :name, :current_user
    private :name=, :current_user=              # Found technique to use private with symbols
                                                # https://stackoverflow.com/questions/25571642/ruby-private-and-public-accessors

    def self.start 
        puts "Hi! Please tell me your name!"
        @name = STDIN.gets.chomp                # Rake doesn't receive 'gets' only STDIN, fixed for now; https://stackoverflow.com/questions/19087611/accepting-user-input-from-the-console-command-prompt-inside-a-rake-task/19087705
        SignIn.log_in?(@name)
    end

    # Visual Success Test
    def self.user_menu
        puts "================================================DEBUG================================================"
        puts ""
        puts ""
        puts ""
        puts "                      THE CURRENT USER THAT IS LOGGED IN IS #{@current_user.name}"
        puts ""
        puts ""
        puts "================================================DEBUG================================================"
    end

    # logs user into account
    def self.log_in_to_account(logged_in_user)
        @current_user = logged_in_user
        self.user_menu
    end
    
    
end


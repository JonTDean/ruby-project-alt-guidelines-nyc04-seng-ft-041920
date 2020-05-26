require_relative 'cli_methods/cli_user_controller'

# Use Dependency Injection Techniques in order to create a Top-Level Handler
# https://en.wikipedia.org/wiki/Dependency_injection
# EX: https://stackoverflow.com/questions/31360945/call-a-method-in-a-class-in-another-class-in-ruby
# Pros: Neater Method calling, easier method organization
# Cons: More Overhead, extra intricacy

class CLIController
    # Goal is to have this be the main access point to the other menus.
    # Allows for scalability with additional menus/features
    # the screens can also be organized and called in a modular design
    
    def initialize
        CLIController.start_user_auth_process
    end

    # Log In Menu / User Account Create Menu
    def self.start_user_auth_process
        CLIUserController.new
    end

    # Debug Menu
    def self.start_debug_menu
        Deanbug.boot
    end

end

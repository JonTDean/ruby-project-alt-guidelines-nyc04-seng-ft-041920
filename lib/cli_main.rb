require_relative 'cli_methods/cli_user.rb'

# Use Dependency Injection Techniques in order to create a Top-Level Handler
# https://en.wikipedia.org/wiki/Dependency_injection
# EX: https://stackoverflow.com/questions/31360945/call-a-method-in-a-class-in-another-class-in-ruby
# Pros: Neater Method calling, easier method organization
# Cons: More Overhead, extra intricacy

class CommandLineInterface
    # Goal is to have this be the main access point to the other menus.
    # Allows for scalability with additional menus/features
    # the screens can also be organized and called in a modular design

    attr_reader :user_screen
    @@Screens

    def initialize(cli_args)
        @user_screen = cli_args[:user_menu]
        self.save << @user_screen
    end

    def self.save
        @@Screens << save
    end

end

# user_menu = CommandLineInterface.new(who_are_you?)

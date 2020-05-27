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
        # CLIController.start_user_auth_process
        CLIController.welcome_screen

    end

    # Log In Menu / User Account Create Menu
    def self.start_user_auth_process
        CLIUserController.new
    end

    # Debug Menu
    def self.start_debug_menu
        Deanbug.boot
    end

    # Welcome screen
    def self.welcome_screen
        puts "Welcome to our awesome project: name TBD"
        #ascii art
        
        #wait times
        self.start_screen
    end

    # User Start Screen
    def self.start_screen
        choice = CLI.prompts.select("What would you like to do?", %w(Sign\ Up Log\ In Options Exit))
        
        case choice
        when "Sign Up"
            UserAccountCreation.ask_user_create?

        when "Log In"
            SignIn.log_in?
            
        when "Options"
            Deanbug.boot
        when "Exit"
            CLI.close
        end
    end

    # Opens Main area where the user is able to interact with
    def self.user_portal
        choice = CLI.prompts.select("Where would you like to go?", ["Recipes", "Profile",  "Log Out"])
            case choice
                when "Recipes"
                    CLIController.recipe_select_menu

                when "Profile"
                    CLIController.profile_select_menu

                when "Log Out"
                    CLIUserController.log_out?
            end
    end

    # Opens up a selection prompt in order to select recipes.
    def self.recipe_select_menu
        choice = CLI.prompts.select("What would you like to do?", ["View my Recipes", "Edit a Recipe", "Create a Recipe", "Delete a Recipe", "Main Menu"])
        case choice
            when "View my Recipes"
                RecipeController.show_user_recipes("view")
            when "Edit a Recipe"
                RecipeController.show_user_recipes("update")
            when "Create a Recipe"
                RecipeController.show_user_recipes("create")
            when "Delete a Recipe"
                RecipeController.show_user_recipes("delete")
            when "Main Menu"
                CLIController.user_portal
        end
    end
    
    # Opens up a selection prompt in order to Traverse User Settings
    def self.profile_select_menu
        choice = CLI.prompts.select("What would you like to do?", ["Update my Profile", "Delete my Account", "Main Menu"])
        case choice
            when "Update my Profile"
                CLIUserController.update_account_menu
                
            when "Delete my Account"
                CLIUserController.delete_account
            when "Main Menu"
                CLIController.user_portal
        end
    end
end

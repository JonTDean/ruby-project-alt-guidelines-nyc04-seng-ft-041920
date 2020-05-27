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
        CLI.prompts.say("Welcome #{CLIUserController.my_name?}")
        choice = CLI.prompts.select("Where would you like to go?", ["Recipes", "Profile",  "Log Out"])
            case choice

                when "Recipes"
                    CLIController.recipe_length_check

                when "Profile"
                    CLIController.profile_select_menu                                   # Goes to the Profile Options Menu

                when "Log Out"
                    CLIUserController.log_out?                                          # Sets current_user to nil and Closes the program
            end
    end

    # Opens up a selection prompt in order to select recipes.
    def self.full_recipe_select_menu
        choice = CLI.prompts.select("What would you like to do?", ["View my Recipes", "View All Recipes", "Edit a Recipe", "Create a Recipe", "Delete a Recipe", "Go back to Main Menu"])

        case choice
            when "View my Recipes"
                RecipeController.show_user_recipes("view")
                CLIController.recipe_length_check

            when "View All Recipes"
                RecipeController.show_all_recipes
                CLIController.recipe_length_check

            when "Edit a Recipe"
                RecipeController.show_user_recipes("update")
                CLIController.recipe_length_check

            when "Create a Recipe"
                RecipeController.ask_for_recipe_details
                CLIController.recipe_length_check

            when "Delete a Recipe"
               RecipeController.show_user_recipes("delete")
               CLIController.recipe_length_check

            when "Go back to Main Menu"
                CLIController.user_portal
                
        end
    end

    # If the user has no Recipes then this Menu prompts them to either create a Recipe or Head back to the main menu.
    def self.recipe_create_menu
        choice = CLI.prompts.select("You don't have any Recipes! Would you like to Create One?", ["Create a Recipe", "Go back to Main Menu"])

            case choice
                when "Create a Recipe"
                    RecipeController.ask_for_recipe_details
                    CLIController.recipe_length_check

                when "Go back to Main Menu"
                    CLIController.user_portal 
            end
    end

    # Checks <Table :: Recipe>
    def self.recipe_length_check
        
        if CLIUserController.current_user?.user_recipes > 0                 # Checks if the user has any recipes in their <recipes> table
            CLIController.full_recipe_select_menu                           # Selects Full Recipe Menu
        else
            CLIController.recipe_create_menu                                # Heads to Recipe Create menu if <recipes> table is empty
        end
    end
    
    # Opens up a selection prompt in order to Traverse User Settings
    def self.profile_select_menu
        choice = CLI.prompts.select("What would you like to do?", ["Update my Profile", "Delete my Account", "Go back to Main Menu"])
        case choice
            when "Update my Profile"
                CLIUserController.update_account_menu
                
            when "Delete my Account"
                CLIUserController.delete_account

            when "Go back to Main Menu"
                CLIController.user_portal
        end
    end
end

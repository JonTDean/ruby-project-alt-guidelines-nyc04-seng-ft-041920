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
        system "clear"                  # Cleans Screen Up
        CLIController.welcome_screen    # Goes to Welcome Screen

    end

    # Debug Menu
    def self.start_debug_menu
        Deanbug.boot                    # Debug Menu portal
    end

    # Welcome screen
    def self.welcome_screen
        CLI.prompts.say( CLIStyle.cake("Welcome to:"))
        sleep(0.75)
        CLI.logo
        #ascii art
        
        #wait times
        sleep(1)
        self.start_screen
    end

    # User Start Screen
    def self.start_screen
        message = CLIStyle.cake("What would you like to do?")
        choice = CLI.prompts.select(message, active_color: :menu) do |menu|
            menu.choice CLIStyle.colors("Sign Up", "#edffec"), "Sign Up"
            menu.choice CLIStyle.colors("Log In", "#5d2e8c"), "Log In"
            menu.choice CLIStyle.colors("Options", "#e4b363"), "Options"
            menu.choice CLIStyle.colors("Exit", "#06d6a0"), "Exit"
        end
        
        case choice
        when "Sign Up"                                          # Go to Sign Up menu
            UserAccountCreation.ask_user_create?

        when "Log In"                                           # Go to Log In menu
            SignIn.log_in?
            
        when "Options"                                          # Go to debug menu
            Deanbug.boot

        when "Exit"                                             # Exits the Program
            CLI.close
            
        end
    end

    # Opens Main area where the user is able to interact with
    def self.user_portal
        sleep(0.7)
        message = CLIStyle.cake("Where would you like to go?")
        choice = CLI.prompts.select(message, ["Recipes", "Profile",  "Log Out"]) do |menu|
            menu.choice CLIStyle.colors("Recipes", "#e8d7f1"), "Recipes"
            menu.choice CLIStyle.colors("Profile", "#5d2e8c"), "Profile"
            menu.choice CLIStyle.colors("Log Out", "#e4b363"), "Log Out"
        end
            case choice

                when "Recipes"
                    CLIController.recipe_length_check

                when "Profile"
                    CLIController.profile_options_menu                                  # Goes to the Profile Options Menu

                when "Log Out"
                    CLIUserController.log_out?                                          # Sets current_user to nil and Closes the program
            end
    end

    # Opens up a selection prompt in order to select recipes.
    def self.full_recipe_select_menu
        
        message = CLIStyle.cake("What would you like to do?")

        # Recipe Menu
        choice = CLI.prompts.select(message) do |menu|
            # Colors in the menu
            menu.choice CLIStyle.colors("View my Recipes", "#C69DD2"), "View my Recipes"
            menu.choice CLIStyle.colors("View All Recipes", "#7ac74f"), "View All Recipes"
            menu.choice CLIStyle.colors("Edit a Recipe", "#06d6a0"), "Edit a Recipe"
            menu.choice CLIStyle.colors("Create a Recipe", "#e4b363"), "Create a Recipe"
            menu.choice CLIStyle.colors("Delete a Recipe", "#ff3366"), "Delete a Recipe"
            menu.choice CLIStyle.colors("Go back to Main Menu", "#5d2e8c"), "Go back to Main Menu"
        end

        case choice
            when "View my Recipes"
                system "clear"
                RecipeController.show_user_recipes("view")
                CLIController.recipe_length_check

            when "View All Recipes"
                RecipeController.show_all_recipes
                CLIController.recipe_length_check

            when "Edit a Recipe"
                system "clear"
                RecipeController.show_user_recipes("update")
                CLIController.recipe_length_check

            when "Create a Recipe"
                system "clear"
                RecipeController.ask_for_recipe_details
                CLIController.recipe_length_check

            when "Delete a Recipe"
                system "clear"
               RecipeController.show_user_recipes("delete")
               CLIController.recipe_length_check
              

            when "Go back to Main Menu"
                system "clear"
                CLIController.user_portal
        end
    end

    # If the user has no Recipes then this Menu prompts them to either create a Recipe or Head back to the main menu.
    def self.recipe_create_menu
        choice = CLI.prompts.select("You don't have any Recipes! Would you like to Create One?", ["Create a Recipe", "Go back to Main Menu"])

            case choice
                when "Create a Recipe"
                    system "clear"
                    RecipeController.ask_for_recipe_details
                    CLIController.recipe_length_check
                    

                when "Go back to Main Menu"
                    system "clear"
                    CLIController.user_portal 
            end
    end

    # Checks <Table :: Recipe>
    def self.recipe_length_check
        CLIUserController.current_user?.reload
        sleep(0.5)
        if CLIUserController.current_user?.user_recipes > 0                 # Checks if the user has any recipes in their <recipes> table
            CLIController.full_recipe_select_menu                           # Selects Full Recipe Menu
        else
            CLIController.recipe_create_menu                                # Heads to Recipe Create menu if <recipes> table is empty
        end
    end
    
    # Opens up a selection prompt in order to Traverse User Settings
    def self.profile_options_menu
        choice = CLI.prompts.select("What would you like to do?", ["Update my Profile", "Delete my Account", "Go back to Main Menu"])
        case choice
            when "Update my Profile"
                system "clear"
                CLIUserController.update_account_menu
                
            when "Delete my Account"
                system "clear"
                CLIUserController.delete_account

            when "Go back to Main Menu"
                system "clear"
                CLIController.user_portal
        end
    end
end

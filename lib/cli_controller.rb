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

    def self.start_screen
        choice = CLI.prompts.select("What would you like to do?", %w(Sign\ Up Log\ In Options))
        
        case choice
        when "Sign Up"
            UserAccountCreation.ask_user_create?
        when "Log In"
            SignIn.log_in?
            
        when "Options"
            Deanbug.boot
        end
    end

    def self.user_portal

        choice = CLI.prompts.select("Where would you like to go?", ["recipes", "profile"])

            case choice
                when "recipes"
                    if CLIUserController.current_user?.recipes.length > 0
                        CLIController.full_recipe_select_menu
                    else
                        CLIController.recipe_create_menu
                    end
                when "profile"
                    # CLIUserController.update_account_menu
                    CLIController.profile_select_menu
            end
            
    end

    def self.full_recipe_select_menu
        choice = CLI.prompts.select("What would you like to do?", ["view my recipes", "edit a recipe", "create a recipe", "delete a recipe"])

        case choice
            when "view my recipes"
                RecipeController.show_user_recipes("view")
            when "edit a recipe"
                RecipeController.show_user_recipes("update")
            when "create a recipe"
                RecipeController.ask_for_recipe_details
            when "delete a recipe"
                RecipeController.show_user_recipes("delete")
        end
    end

    def self.recipe_create_menu
        choice = CLI.prompts.select("What would you like to do?", ["create a recipe"])

            case choice
                when "create a recipe"
                    RecipeController.ask_for_recipe_details
            end
    end
    
    def self.profile_select_menu
        choice = CLI.prompts.select("What would you like to do?", ["update my profile", "delete account"])
        case choice    
            # when "view my profile"
            #     CLIUserController.my_name?

            when "update my profile"
                # puts  "UPDATING THE PROFILE"
                CLIUserController.update_account_menu
                
            when "delete account"
                CLIUserController.delete_account
        end
    end



    # def interact_with_recipes

    # end

end

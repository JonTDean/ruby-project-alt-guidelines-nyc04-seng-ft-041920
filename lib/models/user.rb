class User < ActiveRecord::Base
    has_many :recipes
    has_many :orders, through: :recipes

    def user_recipe_titles
        self.recipes.map{|recipe| recipe.title}
    end

    def select_user_recipe_by_title(action)
        CLI.prompts.select("Please select one of your recipes to #{action}", self.user_recipe_titles)
    end

    def user_recipes
        self.recipes.length
    end

    # Deletes User from Table
    def delete_account
        choice = CLI.prompts.select("Are you sure you want to delete your Account", ["Yes", "No"])
        case choice 
        when /Yes/
            User.destroy(self.id)                       # Deletes the user from the table
            Recipe.destroy_all(user_id: self.id)        # Deletes the Recipes associated with the current User
            CLI.prompts.say("Your account, and all recipes associated with your account, have been deleted. Heading towards the Start Menu...")
            CLIController.start_screen                  # Goes to Start Screen
        when /No/
            CLI.prompts.say("Account was not deleted, heading to Main Menu!")
            CLIController.profile_options_menu           # Goes back to Profile Select Menu
        end
    end
        
end
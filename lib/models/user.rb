class User < ActiveRecord::Base
    has_many :recipes
    has_many :orders, through: :recipes

    def user_recipe_titles
        self.recipes.map{|recipe| recipe.title}
    end

    def select_user_recipe_by_title(action)
        CLI.prompts.select("Please select one of your recipes to #{action}", self.user_recipe_titles)
    end
    
    # Deletes User from Table
    def delete_account
        choice = CLI.prompts.select("Are you sure you want to delete your Account", ["Yes", "No"])
        case choice 
        when /Yes/
            User.destroy(self.id)
            CLI.prompts.say("Your account was deleted. Heading to the Start Menu...")
            CLIController.start_screen
        when /No/
            CLI.prompts.say("Account was not deleted, heading to Main Menu!")
            CLIController.profile_select_menu
        end
    end
        
end
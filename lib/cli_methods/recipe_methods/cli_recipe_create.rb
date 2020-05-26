require_relative '../../models/recipe'
require_relative '../../models/cli'
# require_relative '../user_methods'
# require_relative '../../models/user'

class RecipeCreation
    def self.ask_for_recipe_details
        title = CLI.prompts.ask("What is the name of your recipe?")

        # check all the recipes in the database
        # if that name already exists, ask for a new one
        while Recipe.find_by(title: title)
            title = CLI.prompts.ask("Sorry, that name is already taken. Please type another name for your recipe:")
        end
  
        category = CLI.prompts.select("Please choose a category", %w(Cake Cookies Pie Cheesecake Frosting Ice\ Cream\ or\ Frozen Pudding Other))

        Recipe.create(user_id: CLIUserController.current_user?.id, title: title, category:category)
    end

    #action could be delete, update, view 
    def self.show_user_recipes(action)
        current_user = CLIUserController.current_user?
        title = CLI.prompts.select("Which recipe would you like to #{action}?", current_user.user_recipe_titles)

        recipe = Recipe.find_by(title: title)
        case action
        when "delete"
            recipe.remove_recipe
        
        when "view"
            #view recipe
            recipe.view_recipe.each{|element| puts element}

        when "update"
            #update recipe
            item = CLI.prompts.select("Which item would you like to #{action}?", recipe.view_recipe)
            item_part = CLI.prompts.select("Which part would you like to #{action}?", item.split(" "))
            #actually update it
            
        else
            #shouldn't get here
            puts "reached else in case statement"
        end
    end

    
end


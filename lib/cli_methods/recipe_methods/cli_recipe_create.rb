require_relative '../../models/recipe'
require_relative '../../models/cli'

class RecipeController
    def self.ask_for_recipe_details

        title = CLI.prompts.ask("What is the name of your recipe?")

        # check all the recipes in the database
        # if that name already exists, ask for a new one
        while Recipe.find_by(title: title)
            title = CLI.prompts.ask("Sorry, that name is already taken. Please type another name for your recipe:")
        end
  
        category = CLI.prompts.select("Please choose a category", %w(Cake Cookies Pie Cheesecake Frosting Ice\ Cream\ or\ Frozen Pudding Other))

        recipe = Recipe.create(user_id: CLIUserController.current_user?.id, title: title, category:category)
        recipe_id = recipe.id

        # ask for all ingredients etc
        # result = CLI.prompts.collect do 
        ingredient = IngredientController.choose_an_ingredient      # Returns Ingredient Object
        unit = UnitController.choose_a_unit
        amount = CLI.prompts.ask("How many #{unit.name}s of #{ingredient.name}?", required: true)
       
        Order.create(recipe_id: recipe_id, unit_id: unit.id, ingredient_id: ingredient.id, amount: amount)
        # end

        while CLI.prompts.yes?("Would you like to add another ingredient?")
            ingredient = IngredientController.choose_an_ingredient      # Returns Ingredient Object
        unit = UnitController.choose_a_unit
        amount = CLI.prompts.ask("How many #{unit.name}s of #{ingredient.name}?", required: true)
        Order.create(recipe_id: recipe_id, unit_id: unit.id, ingredient_id: ingredient.id, amount: amount)
        end
        #and push to tables with correct ids

        CLI.prompts.ok("You finished creating the recipe")
        CLI.prompts.say(recipe.view_recipe.join("\n"))
    end

    #action could be delete, update, view 
    def self.show_user_recipes(action)
        current_user = CLIUserController.current_user?
        # title = CLI.prompts.select("Which recipe would you like to #{action}?", current_user.user_recipe_titles)
        title = current_user.select_user_recipe_by_title(action)

        recipe = Recipe.find_by(title: title)
        case action
        when "delete"
            recipe.remove_recipe
            CLI.prompts.say("Recipe has been deleted.")
            # current_user.user_recipe_titles

        
        when "view"
            #view recipe
            CLI.prompts.say(recipe.view_recipe.join("\n"))

        when "update"

            #update recipe
            item = CLI.prompts.select("Which item would you like to #{action}?", recipe.view_recipe)
            index = recipe.view_recipe.index(item)
            puts index
            item_part = CLI.prompts.select("Which part would you like to #{action}?", item.split(" ", 3)) #accounts for ingredients that are more than one word

            # if it is the amount
            if item_part == item.split(" ", 3)[0]
                #amount
                new_amount = CLI.prompts.ask('What would you like to change it to?', required: true)
                # update the amount in the corresponding order
                recipe.orders[index].update(amount: new_amount)

                #############add something to make sure they don't leave it blank
            elsif item_part == item.split(" ", 3)[1]
                #unit
                #make this a color so easier to see??
                CLI.prompts.ok("You are currently updating #{item}")
                new_unit = UnitController.choose_a_unit
                recipe.orders[index].update(unit_id: new_unit.id)

                # display somehow to show it was changed
                puts "Your edit was successful!"
                puts "#{recipe.orders[index].amount} #{Unit.find(recipe.orders[index].unit_id).name} #{Ingredient.find(recipe.orders[index].ingredient_id).name}"
            else
                #ingredient
                puts "You are currently updating #{item}"
                new_ingredient = IngredientController.choose_an_ingredient
                recipe.orders[index].update(ingredient_id: new_ingredient.id)
            end

            
        else
            #shouldn't get here
            puts "reached else in case statement"
        end

        CLIController.user_portal

        

    end

    
end


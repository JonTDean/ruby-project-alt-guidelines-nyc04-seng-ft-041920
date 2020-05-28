require_relative '../models/recipe'
require_relative '../models/cli'

class RecipeController
    def self.ask_for_recipe_details

        title = CLI.prompts.ask("What is the name of your recipe?", required: true)

        # check all the recipes in the database
        # if that name already exists, ask for a new one
        while Recipe.find_by(title: title)
            title = CLI.prompts.ask("Sorry, that name is already taken. Please type another name for your recipe:")
        end
        sleep(0.5)
        category = CLI.prompts.select("Please choose a category", %w(Cake Cookies Pie Cheesecake Frosting Ice\ Cream\ or\ Frozen Pudding Chocolate Candy Other))

        recipe = Recipe.create(user_id: CLIUserController.current_user?.id, title: title, category:category)
        recipe_id = recipe.id

        # ask for all ingredients etc
        # result = CLI.prompts.collect do 
        sleep(0.5)
        ingredient = IngredientController.choose_an_ingredient      # Returns Ingredient Object
        sleep(0.5)
        unit = UnitController.choose_a_unit
        sleep(0.25)
        amount = CLI.prompts.ask("How many #{unit.name} of #{ingredient.name}?", required: true)
       
        Order.create(recipe_id: recipe_id, unit_id: unit.id, ingredient_id: ingredient.id, amount: amount)
        # end
        sleep(0.5)
        while CLI.prompts.yes?("Would you like to add another ingredient?")
            ingredient = IngredientController.choose_an_ingredient      # Returns Ingredient Object
            sleep(0.5)
            unit = UnitController.choose_a_unit
            sleep(0.25)
            amount = CLI.prompts.ask("How many #{unit.name} of #{ingredient.name}?", required: true)
            Order.create(recipe_id: recipe_id, unit_id: unit.id, ingredient_id: ingredient.id, amount: amount)
            sleep(0.25)
        end
        sleep(0.5)
        directions = CLI.prompts.ask("Please add recipe instructions:", required: true)
        recipe.update_directions(directions)

        #and push to tables with correct ids
        sleep(0.25)
        CLI.prompts.say("Adding the recipe to our database...")
        sleep(1)
        CLI.prompts.ok("You finished creating the recipe:")
        puts ""
        CLI.prompts.say(recipe.pretty_view)
        puts ""
        sleep(2)
        
        
    end

    #action could be delete, update, view 
    def self.show_user_recipes(action)
        current_user = CLIUserController.current_user?
        # title = CLI.prompts.select("Which recipe would you like to #{action}?", current_user.user_recipe_titles)
        title = current_user.select_user_recipe_by_title(action)

        recipe = Recipe.find_by(title: title)

        sleep(0.5)
        case action
        when "delete"
            recipe.remove_recipe
            CLI.prompts.say("Recipe has been deleted.")
            # current_user.user_recipe_titles

        
        when "view"
            #view recipe
            system "clear"
            CLI.prompts.say(recipe.pretty_view)
            sleep(2)

        when "update"

            #update recipe
            item = CLI.prompts.select("Which item would you like to #{action}?", recipe.view_recipe)



            index = recipe.view_recipe.index(item)
            # if they are updating the instructions
            if recipe.directions == item #index = recipe.view_recipe.length - 1
                new_directions = CLI.prompts.ask('What would you like to change it to?', required: true)

                recipe.update(directions: new_directions)

                # if they are updating one of the recipeIngredients
                else
                item_part = CLI.prompts.select("Which part would you like to #{action}?", item.split(" ", 3)) #accounts for ingredients that are more than one word

                # if it is the amount
                if item_part == item.split(" ", 3)[0]
                    #amount
                    new_amount = CLI.prompts.ask('What would you like to change it to?', required: true)
                    # update the amount in the corresponding order
                    recipe.orders[index].update(amount: new_amount)

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
                sleep(0.5)
                puts ""
                    puts "Updating recipe in database..."
                    sleep(0.7)
                    puts ""
                    puts "Recipe successfully updated."
                    puts ""
                    sleep(0.3)
            end

            
        else
            #shouldn't get here
            puts "reached else in case statement"
        end

        CLIController.user_portal  

    end

    def self.show_all_recipes
        # Recipe.all.each do |r|
        #      user = User.find_by(id: r.user_id)
        #      CLI.prompts.say("Recipe By: #{user.name}", color: :blue)
        #      CLI.prompts.say("Recipe Name: #{r.title}", color: :blue)
        #      CLI.prompts.say("Recipe Category: #{r.category}", color: :blue)
        #      CLI.prompts.say("Recipe Directions: #{r.directions}", color: :blue)
        #      puts ""
        #      puts ""
        # end
        test = Recipe.all.map do |r|
            "Recipe By: #{User.find_by(id: r.user_id).name}\n\
            Recipe Name: #{r.title}\n\
            Recipe Category: #{r.category}\n\
            Recipe Directions: #{r.directions}\n\n\n"
       end
        recipe_details = CLI.prompts.select("Which recipe would you like to view? (←/→ arrow keys to view more pages)", test, color: :blue, per_page: 4)
        index = test.find_index(recipe_details)
        recipe = Recipe.all[index]
        
        sleep(0.5)
        puts ""
        recipe.pretty_view
        puts ""
        sleep(2)
    end
    
end


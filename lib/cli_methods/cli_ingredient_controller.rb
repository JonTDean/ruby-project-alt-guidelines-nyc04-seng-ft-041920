require_relative '../models/ingredient'
require_relative './cli_user_controller'

class IngredientController
    @name = Ingredient.all.map(&:name) # Returns all of the Ingredient names from Ingredient table

    def self.choose_an_ingredient      # Returns Ingredient Object
        CLI.prompts.select("Please choose an Ingredient", @name)                        # Asks user to choose an ingredient

    end

    def self.view_ingredients
        CLI.prompts.select("These are your available Ingredients", @name, echo: false)  # Displays list of Ingredients, Need to remove selection process or find better way to display.
        0 # Not a Typo, used for return
    end

    def self.add_ingredient(input)
        Ingredient.create(name: input)
    end
end

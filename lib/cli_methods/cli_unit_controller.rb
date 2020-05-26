require_relative '../models/unit'
require_relative './cli_user_controller'

class IngredientController      
    @name = Unit.all.map(&:name) # Returns all of the Ingredient names from Ingredient table

    def self.choose_a_unit       # Returns Unit Object
        choice = CLI.prompts.select("Please choose a Unit", @name)                  # Asks user to choose a Unit
        Unit.find_by(name: choice)
    end

    def self.view_units
        CLI.prompts.select("These are your available Units", @name, echo: false)    # Displays list of Units, Need to remove selection process or find better way to display.
        0 # Not a Typo, used for return
    end
end
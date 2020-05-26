require_relative '../models/ingredient'

class IngredientController
    # UserController
    def self.find_user(name)
        User.find_by(name: name)
    end
end



# - [x] Seed Database With Ingredients
# - [ ] Gather Prompt
# - [ ] Select Prompt to show all the ingredients
    
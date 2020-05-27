class Recipe < ActiveRecord::Base
    has_many :orders
    belongs_to :users
    has_many :ingredients, through: :orders
    has_many :units, through: :orders


    def remove_recipe
        self.destroy
    end

    def update_directions(directions)
        self.update(directions: directions)
    end

    def view_recipe
        recipe_array = self.orders.map do |order| 
            "#{order.amount} #{Unit.find(order.unit_id).name} #{Ingredient.find(order.ingredient_id).name}"
        end
        recipe_array.push(self.directions)
    end
end
class Recipe < ActiveRecord::Base
    has_many :orders
    belongs_to :users
    has_many :ingredients, through: :orders
    has_many :units, through: :orders


    def remove_recipe
        self.destroy
    end

    def user
        User.find(self.user_id)
    end

    def update_directions(directions)
        self.update(directions: directions)
    end

    def pretty_orders
        self.orders.map do |order| 
            "#{order.amount} #{Unit.find(order.unit_id).name} #{Ingredient.find(order.ingredient_id).name}"
        end
    end

    def view_recipe
        recipe_array = self.pretty_orders
        recipe_array.push(self.directions)
    end

    def pretty_view
        puts "Recipe Name: #{self.title}"        
        puts "Created By: #{self.user.name}"
        puts "\nIngredients:\n------------"
        puts  self.pretty_orders.join("\n")

        puts "\nDirections:"
        puts "-----------\n#{self.directions}"

    end
end
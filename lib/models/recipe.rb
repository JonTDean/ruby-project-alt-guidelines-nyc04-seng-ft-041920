class Recipe < ActiveRecord::Base
    has_many :orders
    belongs_to :users
    has_many :ingredients, through: :orders
    has_many :units, through: :orders

    # def self.remove_recipe(title)
    #     recipe = Recipe.find_by(title: title)
    #     recipe.destroy
    # end

    def remove_recipe
            # recipe = Recipe.find_by(title: title)
            self.destroy
        end

    def view_recipe
        # recipe.Recipe.find_by(title: title)
        self.orders.map do |order| 
            "#{order.amount} #{Unit.find(order.unit_id).name} #{Ingredient.find(order.ingredient_id).name}"
            # ingredient_ids = order.ingredient_id
            # unit_ids = order.unit_id
            # ingredient_ids = order.ingredient_id
    end

    # def update_item(item)

    # end


    end


end
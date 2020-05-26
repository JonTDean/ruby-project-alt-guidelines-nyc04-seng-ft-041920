class Recipe < ActiveRecord::Base
    has_many :orders
    belongs_to :users
    has_many :ingredients, through: :orders
    has_many :units, through: :orders


    def remove_recipe
        self.destroy
    end

    def view_recipe
        self.orders.map do |order| 
            "#{order.amount} #{Unit.find(order.unit_id).name} #{Ingredient.find(order.ingredient_id).name}"
        end
    end
end
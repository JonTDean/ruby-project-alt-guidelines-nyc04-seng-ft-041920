class Ingredient < ActiveRecord::Base
    has_many :orders
    has_many :recipes, through: :orders
    has_many :units, through: :orders
end
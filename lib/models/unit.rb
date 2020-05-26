class Unit < ActiveRecord::Base
    has_many :orders
    has_many :ingredients, through: :orders
    has_many :recipes, through: :orders
end
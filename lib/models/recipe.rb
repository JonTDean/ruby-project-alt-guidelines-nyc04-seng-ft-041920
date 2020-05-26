class Recipe < ActiveRecord::Base
    has_many :orders
    belongs_to :users
    has_many :ingredients, through: :orders
    has_many :units, through: :orders


end
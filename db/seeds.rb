require 'faker'
#USER
User.create(name: Faker::Name.unique.name, password: "1234")
User.create(name: Faker::Name.unique.name, password: "1234")

#INGREDIENTS
Ingredient.create(name: Faker::Food.unique.ingredient)
Ingredient.create(name: Faker::Food.unique.ingredient)
Ingredient.create(name: Faker::Food.unique.ingredient)
Ingredient.create(name: Faker::Food.unique.ingredient)
Ingredient.create(name: Faker::Food.unique.ingredient)

#RECIPES
Recipe.create(title: Faker::Food.unique.dish,  user_id: 1)
Recipe.create(title: Faker::Food.unique.dish,  user_id: 2)


#UNITS
#SPLIT MEASUREMENT BY [0] = Amount :: [1] = name
split = Faker::Food.measurement.split(" ")

Unit.create(name: split[1])

# binding.pry

#ORDERS
Order.create(recipe_id: 1, ingredient_id: 2, unit_id: 1, amount: split[0].to_f)
Order.create(recipe_id: 2, ingredient_id: 1, unit_id: 1, amount: split[0].to_f)
Order.create(recipe_id: 1, ingredient_id: 1, unit_id: 1, amount: split[0].to_f)
Order.create(recipe_id: 2, ingredient_id: 2, unit_id: 1, amount: split[0].to_f)

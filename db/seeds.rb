require 'faker'
#USER #can't really seed user because of bcrypt
User.create(name: Faker::Name.unique.name, password: "1234")
User.create(name: Faker::Name.unique.name, password: "1234")
# User.create(name: "testdummy", password: "testdummy")
# User.create(name: "elisheva", password: "elisheva")
# User.create(name: "jonny", password: "jonny")


#INGREDIENTS
Ingredient.create(name: "flour")
Ingredient.create(name: "sugar")
Ingredient.create(name: "oil")
Ingredient.create(name: "brown sugar")
Ingredient.create(name: "honey")
Ingredient.create(name: "cocoa powder")
Ingredient.create(name: "eggs(s)")
Ingredient.create(name: "applesauce")
Ingredient.create(name: "baking powder")
Ingredient.create(name: "baking soda")
Ingredient.create(name: "vanilla")
Ingredient.create(name: "butter")
Ingredient.create(name: "milk")
Ingredient.create(name: "salt")
Ingredient.create(name: "cinnamon")
Ingredient.create(name: "walnuts")
Ingredient.create(name: "pecans")
Ingredient.create(name: "almonds")
Ingredient.create(name: "apple(s)")
Ingredient.create(name: "jam")
Ingredient.create(name: "corn syrup")




#RECIPES
Recipe.create(title: Faker::Food.unique.dish,  user_id: 1, directions: Faker::Food.description, category: "Cake")
Recipe.create(title: Faker::Food.unique.dish,  user_id: 2, directions: Faker::Food.description, category: "Cookies")


#UNITS
#SPLIT MEASUREMENT BY [0] = Amount :: [1] = name
split1 = Faker::Food.measurement.split(" ")
split2 = Faker::Food.measurement.split(" ")
split3 = Faker::Food.measurement.split(" ")


# Unit.create(name: split[1])
Unit.create(name: "Tablespoon(s)")
Unit.create(name: "teaspoon(s)")
Unit.create(name: "cup(s)")
Unit.create(name: "pinch(es)")
Unit.create(name: "dash(es)")
Unit.create(name: "pound(s)")
Unit.create(name: "stick(s)")
Unit.create(name: "gallon(s)")
Unit.create(name: "quart(s)")
Unit.create(name: "no unit e.g. eggs, apples")
# binding.pry

#ORDERS
Order.create(recipe_id: 1, ingredient_id: 2, unit_id: 1, amount: split1[0].to_f)
Order.create(recipe_id: 2, ingredient_id: 1, unit_id: 4, amount: split2[0].to_f)
Order.create(recipe_id: 1, ingredient_id: 4, unit_id: 2, amount: split3[0].to_f)
Order.create(recipe_id: 2, ingredient_id: 5, unit_id: 3, amount: split1[0].to_f)

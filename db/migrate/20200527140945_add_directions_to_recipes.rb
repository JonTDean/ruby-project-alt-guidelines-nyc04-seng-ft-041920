class AddDirectionsToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :directions, :text
  end
end

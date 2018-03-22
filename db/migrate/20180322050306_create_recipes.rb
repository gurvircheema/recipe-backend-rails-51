class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :description
      t.text :ingredients, array: true, default: []
      t.text :directions,  array: true, default: []

      t.timestamps
    end
  end
end

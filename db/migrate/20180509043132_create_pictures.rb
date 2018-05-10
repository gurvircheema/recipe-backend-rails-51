class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.references :recipe, foreign_key: true
      t.string :file

      t.timestamps
    end
  end
end

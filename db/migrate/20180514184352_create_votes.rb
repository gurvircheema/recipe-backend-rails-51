class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.references :votable, polymorphic: true
      t.integer :status, limit: 1

      t.timestamps
    end
  end
end

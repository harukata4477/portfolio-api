class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.references :room, null: false, foreign_key: true
      t.integer :judge
      
      t.timestamps
    end
  end
end

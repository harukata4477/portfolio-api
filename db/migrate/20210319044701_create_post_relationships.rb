class CreatePostRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :post_relationships do |t|

      t.timestamps
    end
  end
end

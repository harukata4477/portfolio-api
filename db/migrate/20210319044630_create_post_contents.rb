class CreatePostContents < ActiveRecord::Migration[6.0]
  def change
    create_table :post_contents do |t|
      t.references :post, null: false, foreign_key: true
      t.string :kind
      t.string :title
      t.string :sub_title
      t.string :picture
      t.text :text
      t.integer :order_num, null: false

      t.timestamps
    end
  end
end

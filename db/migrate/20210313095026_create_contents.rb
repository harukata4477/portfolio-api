class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.text :content
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end

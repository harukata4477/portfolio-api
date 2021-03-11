class CreateFollows < ActiveRecord::Migration[6.0]
  def change
    create_table :follows do |t|
      t.references :user, null: false, foreign_key: true
      t.references :follower, null: false, foreign_key: { to_table: :users }

      t.timestamps

      t.index [:user_id, :follower_id], unique: true
    end
  end
end

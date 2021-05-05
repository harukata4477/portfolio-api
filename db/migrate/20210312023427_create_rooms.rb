# frozen_string_literal: true

class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, default: false
      t.boolean :done, default: false
      t.datetime :deadline, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
  end
end

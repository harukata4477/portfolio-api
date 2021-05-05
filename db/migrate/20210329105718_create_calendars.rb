# frozen_string_literal: true

class CreateCalendars < ActiveRecord::Migration[6.0]
  def change
    create_table :calendars do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :color
      t.datetime :start, default: -> { 'current_timestamp()' }
      t.datetime :end, default: -> { 'current_timestamp()' }
      t.boolean :done, default: false

      t.timestamps
    end
  end
end

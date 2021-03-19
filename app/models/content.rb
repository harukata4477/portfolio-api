class Content < ApplicationRecord
  belongs_to :room, optional: true, foreign_key: "room_id"
  serialize :content, Array
  validates :room_id, uniqueness: true
end

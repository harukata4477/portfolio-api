class Post < ApplicationRecord
  has_many :post_contents
  # validates :room_id, uniqueness: true
  validates :room_id, presence: true
  belongs_to :room, optional: true
  has_one :content, through: :room, source: :content
  has_one :user, through: :room, source: :user
end

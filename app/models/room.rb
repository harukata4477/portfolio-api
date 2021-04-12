class Room < ApplicationRecord
  validates :title, presence: true
  belongs_to :user, optional: true
  has_one :content, dependent: :destroy
  has_many :posts, dependent: :destroy
end


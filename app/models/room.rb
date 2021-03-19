class Room < ApplicationRecord
  validates :title, presence: true
<<<<<<< HEAD
  belongs_to :user, optional: true
  has_one :content, dependent: :destroy
=======
  belongs_to :user
>>>>>>> d2a8736f38280a784d3e1920ab575be52bf68cef
end

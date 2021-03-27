class Follow < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :follower, class_name: 'User'
end

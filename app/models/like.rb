# frozen_string_literal: true

class Like < ApplicationRecord
  validates :user_id, presence: true
  validates :post_id, presence: true

  belongs_to :post, optional: true
  belongs_to :user, optional: true
end

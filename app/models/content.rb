# frozen_string_literal: true

class Content < ApplicationRecord
  validates :room_id, uniqueness: true
  serialize :content, Array

  belongs_to :room, optional: true, foreign_key: 'room_id'
end

# frozen_string_literal: true

class Calendar < ApplicationRecord
  validates :name, presence: true
  validates :start, presence: true
  validates :end, presence: true

  belongs_to :user, optional: true
end

# frozen_string_literal: true

class CalendarSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :start, :end, :done, :color, :user_id
end

# frozen_string_literal: true

class RoomSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :deadline, :done, :updated_at

  attributes :room_counts do |_object, params|
    params[:room_counts]
  end
end

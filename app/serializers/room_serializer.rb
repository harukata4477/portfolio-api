class RoomSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :deadline, :done, :updated_at

  attributes :room_counts do |object, params|
    params[:room_counts]
  end
end

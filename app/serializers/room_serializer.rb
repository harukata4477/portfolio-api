class RoomSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :deadline, :done

  # attributes :current_user do |object|
  #   object.user
  # end
end

class RoomSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :deadline, :done
end

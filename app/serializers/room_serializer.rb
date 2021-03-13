class RoomSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id

  attributes :rooms do |object, params|

    if params[:search]
      params[:search]
    else
      object.rooms
    end

  end
end

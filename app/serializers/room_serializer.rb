class RoomSerializer
  include FastJsonapi::ObjectSerializer
<<<<<<< HEAD
  attributes :id, :title, :deadline, :done

  # attributes :current_user do |object|
  #   object.user
  # end
=======

  attributes :id

  attributes :rooms do |object, params|

    if params[:search]
      params[:search]
    else
      object.rooms
    end

  end
>>>>>>> d2a8736f38280a784d3e1920ab575be52bf68cef
end

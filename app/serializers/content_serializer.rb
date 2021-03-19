class ContentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :content

  attributes :room do |object|
    object.room
  end
end

# frozen_string_literal: true

class ContentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :content

  attributes :room, &:room
end

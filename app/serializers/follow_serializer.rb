class FollowSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name

  attributes :followings do |object,  params|
    unless params[:judges]
      params[:followings]
    end
  end

  attributes :followers do |object,  params|
    if params[:judges]
      object.followers
    end
  end
end

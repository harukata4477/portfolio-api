class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :image, :profile
  
  attributes :follow_judge do |object, params|
    if params[:current_user]
      judge = []
      id = object.id
      params[:current_user].follows.map do |f|
        if object.id == f.follower_id
          judge.push(true)
        end
      end
      judge.present?
    end
  end

  attributes :email do |object, params|
    if params[:current_user]
      if params[:current_user].id == object.id
        object.email
      end
    end
  end

  attributes :following do |object, params|
    object.follows.length
  end

  attributes :follower do |object, params|
    object.followers.length
  end

end


class LikeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :user_id, :post_id

  attributes :posts do |object|
    object.post
  end

  attributes :like_counts do |object|
    object.post.likes.length
  end

  attributes :users do |object, params|
    object.user
  end

  attributes :like_judges do |object, params|
    if params[:my_user]
      judge = []
      id = params[:my_user].id
      if object.user_id == id
        judge.push(true)
      end
      judge.present?
    end
  end

end

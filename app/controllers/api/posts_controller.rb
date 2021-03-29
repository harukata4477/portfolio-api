class Api::PostsController < ApplicationController
  def index
    posts = Post.eager_load(:user, :tags, :likes).page(params[:page]).per(10).order(created_at: :desc)
    pagination = generate_pagination(posts)
    judges = true
    my_user = current_user
    json_string = PostSerializer.new(posts,{params: {judge: judges, current_user: my_user}}).serializable_hash.merge(pagination)
    render json: json_string
  end

  def show
    post = Post.eager_load(:user, :tags, :room, :content, :likes, :messages).find(params[:id])
    my_user = current_user
    json_string = PostSerializer.new(post,{params: {current_user: my_user}}).serialized_json
    render json: json_string
  end

  def create
    room_id = Room.find_by(title: params[:room]).id
    post = Post.new(title: params[:title], room_id: room_id, tag_list: params[:tag_list], kind: params[:kind], user_id: current_user.id)
    if post.save
      render json: {post_id: post.id}
    else
      render json: content.errors.messages
    end
  end

  def update
    post = Post.find_by(id: params[:id])
    if post.update(title: params[:title])
      render json: { success_message: '更新完了'}
    else
      render json: { errors: ['更新できませんでした。']}, status: 401
    end
  end

  def destroy
    post = Post.find_by(id: params[:id])
    post.destoy
      render json: { success_message: '削除完了'}
  end

  def post_user
    posts = Post.eager_load(:user, :likes, :tags).where(user_id: params[:id]).page(params[:page]).per(10).order(created_at: :DESC)
    judges = true
    my_user = current_user
    pagination = generate_pagination(posts)
    json_string = PostSerializer.new(posts, {params: {judge: judges, current_user: my_user}}).serializable_hash.merge(pagination)
    render json: json_string
  end

  def post_like
    like = Like.eager_load(post: :tags).where(user_id: params[:id])
    post = []
    like.each do |l|
      post.push(l.post)
    end
    # posts = like.post.eager_load(:user, :likes, :tags).where(user_id: params[:id]).page(params[:page]).per(10).order(created_at: :DESC)
    # judges = true
    # my_user = current_user
    # pagination = generate_pagination(posts)
    # json_string = PostSerializer.new(posts, {params: {judge: judges, current_user: my_user}}).serializable_hash.merge(pagination)
    # render json: json_string
    render json: post
  end

  def search
    posts = Post.where("title LIKE(?)", "%#{params[:id]}%").preload(:user).eager_load(:tags, :likes).page(params[:page]).per(10).order(created_at: :DESC)
    judges = true
    my_user = current_user
    pagination = generate_pagination(posts)
    json_string = PostSerializer.new(posts, {params: {judge: judges, current_user: my_user}}).serializable_hash.merge(pagination)
    render json: json_string
  end
end

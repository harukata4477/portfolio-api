class Api::PostContentsController < ApplicationController
  def show
    post = PostContent.find(params[:id])
    json_string = PostSerializer.new(post).serialized_json
    render json: json_string
  end

  def create
    post = PostContent.new(post_content_params)
    if post.save
      render json: 'ok'
    else
      render json: content.errors.messages
    end
  end

  def update
    post_content = PostContent.find_by(id: params[:id])
    if post_content.update(post_content_params)
      render json: post_content
    else
      render json: { errors: ['更新できませんでした。']}, status: 401
    end
  end

  def destroy
    post_content = PostContent.find_by(id: params[:id])
    post_content.destroy
      render json: { success_message: '削除完了'}
  end

  private
    def post_content_params
      params.permit(:post_id, :kind, :order_num, :title, :sub_title, :text, :picture)
    end
end

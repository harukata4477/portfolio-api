# frozen_string_literal: true

module Api
  class MessagesController < ApplicationController
    def show
      messages = Message.eager_load(:post,
                                    :user).where(post_id: params[:id]).page(params[:page]).per(10).order(created_at: :DESC)
      pagination = generate_pagination(messages)
      set_post = Post.find(params[:id])
      data = MessageSerializer.new(messages, { params: { post: set_post } }).serializable_hash.merge(pagination)
      render json: data
    end
  end
end

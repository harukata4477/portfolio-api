class Api::HelloController < ApplicationController
  def index
    render json: "complete"
  end
end

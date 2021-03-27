require 'securerandom'
class Api::HelloController < ApplicationController
  # before_action :authenticate_user!
  def index
    i = 3
    a = []
    while i > 1 do
      a.push(i)
      i = rand(10)
    end
    render json: {random: a}
  end
end

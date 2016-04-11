class V1::UsersController < ApplicationController

  def empty
    render json: {}
  end
end
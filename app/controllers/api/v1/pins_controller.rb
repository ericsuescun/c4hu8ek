class Api::V1::PinsController < ApplicationController

  before_action :restrict_access

  def index
    render json: Pin.all.order('created_at DESC')
  end

  def create
    pin = Pin.new(pin_params)
    if pin.save
      render json: pin, status: 201
    else
      render json: { errors: pin.errors }, status: 422
    end
  end

  private
    def pin_params
      params.require(:pin).permit(:title, :image_url)
    end

    def restrict_access
      # user1 = User.find(1)
      user1 = User.find_by_email(request.headers["X-User-Email"])
      user2 = User.find_by_api_token(request.headers["X-Api-Token"])
      # user2 = User.find(1)
      if  user1 == user2
        render :json=> {:message=>"Good!"}, :status=>:ok
      else
        render :json=> {:message=>"Error with your credentials"}, :status=>401
      end
    end
end
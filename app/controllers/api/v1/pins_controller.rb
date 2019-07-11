class Api::V1::PinsController < ApplicationController

  before_action :restrict_access

  def index
    render json: Pin.all.order('created_at DESC'), status: :ok
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
      # render :json=> {:message=>"Email: #{request.headers["HTTP_X_USER_EMAIL"]}, token: #{request.headers["HTTP_X_USER_TOKEN"]}"}, :status=>:ok
      # render :json=> {:message=>"Headers #{request.headers["SERVER_PORT"]}"}, :status=>:ok
      # user1 = User.find(1)
      user1 = User.find_by_email(request.headers["HTTP_X_USER_EMAIL"])
      user2 = User.find_by_api_token(request.headers["HTTP_X_USER_TOKEN"])
      # user2 = User.find(1)
      if  user1 != user2
        render :json=> {:message=>"Error with your credentials"}, :status=>401
      end
    end
end

# httparty -H x-user-email:edsuescun@gmail.com -H x-user-token:f40b4da587b01bcbc2372e0ba74b4caa http://localhost:3000/api/v1/pins
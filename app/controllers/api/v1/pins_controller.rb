class Api::V1::PinsController < ApplicationController

  # before_action :restrict_access

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
end

# httparty -H x-user-email:edsuescun@gmail.com -H x-user-token:f40b4da587b01bcbc2372e0ba74b4caa http://localhost:3000/api/v1/pins
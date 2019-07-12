class Api::V1::PinsController < ApplicationController

  # called before every action on controllers
  before_action :authorize_request

  def index
    render json: Pin.all.order('created_at DESC'), status: 200
  end

  def create
    pin = Pin.new(pin_params)
    if pin.save
      render json: pin, status: 200
    else
      render json: { errors: pin.errors }, status: 422
    end
  end

  private
    def pin_params
      params.require(:pin).permit(:title, :image_url)
    end

      def authorize_request
        user = User.find_by_email(request.headers["HTTP_X_USER_EMAIL"])
        if (user == nil) || (user.api_token != request.headers["HTTP_X_USER_TOKEN"])
            json_response({:message=>"Error with your credentials"}, 401)
        end

        # user2 ||= User.find_by_api_token(request.headers["HTTP_X_USER_TOKEN"])
        # raise(ActiveRecord::RecordNotFound) if user2 == nil

        # if (user1 != user2)
        #   json_response({:message=>"Error with your credentials: User1 = #{user1.to_json}, User2 = #{user2.to_json}"}, 401)
        # end
      end
end

# httparty -H x-user-email:edsuescun@gmail.com -H x-user-token:f40b4da587b01bcbc2372e0ba74b4caa http://localhost:3000/api/v1/pins
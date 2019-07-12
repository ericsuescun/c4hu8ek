class ApplicationController < ActionController::Base
  include Response
  include ExceptionHandler

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # protect_from_forgery with: :null_session


  # called before every action on controllers
  before_action :authorize_request
  # attr_reader :current_user

  private

    def authorize_request
      user1 ||= User.find_by_email(request.headers["HTTP_X_USER_EMAIL"])
      raise(ActiveRecord::RecordNotFound) if user1 == nil

      user2 ||= User.find_by_api_token(request.headers["HTTP_X_USER_TOKEN"])
      raise(ActiveRecord::RecordNotFound) if user2 == nil

      if (user1 != user2)
        json_response({:message=>"Error with your credentials: User1 = #{user1.to_json}, User2 = #{user2.to_json}"}, 401)
      end
    end
  	
end


# httparty -H x-user-email:edsuescun@gmail.com -H x-user-token:f40b4da587b01bcbc2372e0ba74b4caa http://localhost:3000/api/v1/pins -vhttparty -H x-user-email:edsuescun@gmail.com -H x-user-token:f40b4da587b01bcbc2372e0ba74b4caa http://localhost:3000/api/v1/pins -v
class ApplicationController < ActionController::Base
  # include Response
  # include ExceptionHandler
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  # called before every action on controllers
  # before_action :authorize_request
  # attr_reader :current_user

  # private

  # 	# Check for valid request token and return user
  # 	def authorize_request
  # 	  @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  # 	end
  	
end


# HTTParty.post("http://localhost:3000/api/v1/pins", headers: { X-USER-EMAIL: "test@example.com", X-USER-TOKEN: "f40b4da587b01bcbc2372e0ba74b4caa" })
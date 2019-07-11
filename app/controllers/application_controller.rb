class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end


# HTTParty.post("http://localhost:3000/api/v1/pins", headers: { X-USER-EMAIL: "test@example.com", X-USER-TOKEN: "f40b4da587b01bcbc2372e0ba74b4caa" })
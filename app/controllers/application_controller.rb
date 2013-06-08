class ApplicationController < ActionController::Base
  #protect_from_forgery

  before_filter :authenticate

  def authenticate
    def authenticate
      if Rails.env.production?
        authenticate_or_request_with_http_basic do |username, password|
          username == "tastytasty" && password == "br0cc0l1$"
        end
      end
    end
  end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :get_cart

  def get_cart
    session[:cart] ||= []
    @cart = session[:cart]
  end

  rescue_from Pundit::NotAuthorizedError do |exception|
        redirect_to root_url, alert: exception.message
  end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :get_cart

  def get_cart
    session[:cart] ||= []
    @cart = session[:cart]
  end
end

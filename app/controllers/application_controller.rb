class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found

  before_filter :set_locale

  protected

  def set_locale
  	# I18n.locale = params[:locale] || I18n.default_locale
  	if params[:locale] && ["en", "zh_tw"].include?(params[:locale])
  		session[:locale] = params[:locale]
  	end
  	I18n.locale = session[:locale] || I18n.default_locale
  end

  def render_not_found
  	render template: 'shared/404', :status => :not_found
  end

end

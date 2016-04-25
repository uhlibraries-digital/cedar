class ApplicationController < ActionController::Base
  include ControllerExtensions

  protect_from_forgery

  before_filter :beforeFilter

  def beforeFilter
    $_URL = request.original_url.split('?')[0]
  end
end
class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :require_login

  add_flash_types :demo
end

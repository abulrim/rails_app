class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pundit
end

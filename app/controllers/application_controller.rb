class ApplicationController < ActionController::Base
  before_action :gon_user

  private

  def gon_user
    gon.user_id = current_user.id if current_user
    gon.user_email = current_user.email if current_user
  end
end

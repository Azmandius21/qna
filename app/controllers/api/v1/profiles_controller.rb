class Api::V1::ProfilesController < Api::V1::BaseController
  def index
    @other_users = User.all.where( 'id != ?', current_resource_owner.id )
    render json: @other_users
  end

  def me
    render json: current_resource_owner
  end
end

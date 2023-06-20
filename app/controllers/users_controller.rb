class UsersController < ApplicationController
  before_action :authenticate_user!

  def show_rewards
    @user = User.find(params[:id])
    @rewards = @user.rewards
  end
end

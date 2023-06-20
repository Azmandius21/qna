class UsersController < ApplicationController
  def show_rewards
    @user = User.find(params[:id])
    @rewards = @user.rewards
  end
end
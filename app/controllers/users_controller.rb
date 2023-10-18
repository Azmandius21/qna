require 'byebug'

class UsersController < ApplicationController
  before_action :authenticate_user!, only: :show_rewards



  def show_rewards
    @user = User.find(params[:id])
    @rewards = @user.rewards
  end

  def extract_email
    @user = User.new
  end

  def confirm_email
    password = Devise.friendly_token[0,10]
    @user = User.create!(
      email: email_params[:email],
      password: password,
      password_confirmation: password
    )
    byebug
    @user.authorization = Authorization.create!(
      uid: session[:uid],
      provider: session[:provider]
    )
    redirect_to root_path
  end

  private

  def email_params
    params.require(:user).permit(:email)
  end
end

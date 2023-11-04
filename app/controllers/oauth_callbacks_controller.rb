require 'byebug'
class OauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :provider_signup, only: %i[ vkontakte github ]
  def github
    # @user = User.find_for_oauth(auth)

    # if @user&.persisted?
    #   sign_in_and_redirect @user, event: :authentication
    #   set_flash_message(:notice, :success, kind: params[:action].capitalize) if is_navigational_format?
    # else
    #   redirect_to root_path, alert: "Something went wrong!!!"
    # end
  end

  def vkontakte
    # @user = User.find_for_oauth(auth)

    # if @user && @user.persisted?
    #   sign_in_and_redirect @user, event: :authentication
    #   set_flash_message(:notice, :success, kind: params[:action].capitalize) if is_navigational_format?
    # else
    #   flash[:notice] = 'Email is required for complit sign up'
    #   render 'oauth_callbacks/request_email', locals: { auth: auth}
    # end
  end

  def email_recipient
    add_email_to_auth

    if auth[:info][:email]
      provider_signup
    else
      rendirect_to root_path, alert: 'Something went wrong!!!'
    end
  end

  private

  def provider_signup
    @user = User.find_for_oauth(auth)

    if @user.nil?
      redirect_to root_path, alert: "Something went wrong!!!"
    elsif @user.present? && @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: params[:action].capitalize) if is_navigational_format?
    else
      flash[:notice] = 'Email is required for complit sign up'
      render 'oauth_callbacks/request_email', locals: { auth: auth}
    end
  end

  def auth
    request.env['omniauth.auth'] || OmniAuth::AuthHash.new(params[:auth])
  end

  def add_email_to_auth
    auth = params[:auth]
    auth[:info] = {email: params[:email]}
  end
end

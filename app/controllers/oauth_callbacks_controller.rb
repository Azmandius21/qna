class OauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :provider_signin, only: %i[ github vkontakte end_of_signin ]
  def github;end

  def vkontakte;end

  def end_of_signin;end

  private

  def provider_signin
    @user = User.find_for_oauth(auth)

    if @user
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: auth.provider.capitalize) if is_navigational_format?
    else
      flash[:notice] = 'Email is required for complit sign_up'
      render 'oauth_callbacks/request_email', locals: { auth: auth }
    end
  end

  def auth
    request.env['omniauth.auth'] || build_auth
  end

  def build_auth
    auth = OmniAuth::AuthHash.new(params[:auth])
    auth.info[:email] = params[:email]
    auth
  end
end

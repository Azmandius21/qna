require 'byebug'
class OauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    authenticate_with('Github')
  end

  def twitter
    authenticate_with('Twitter')
  end

  def vkontakte
    authenticate_with('Vkontakte')
  end

  private

  def authenticate_with(provider)
    auth = request.env['omniauth.auth']
    @user = User.find_for_oauth(auth)

    # byebug

    if @user&.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider ) if is_navigational_format?
    elsif @user.nil? && !auth.nil?
      session[:uid] = auth.info.uid
      session[:provider] = auth.info.provider
      redirect_to extract_email_path
    else
      redirect_to root_path, alert: "Something went wrong"
    end
  end
end

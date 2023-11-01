class Registration::FindForOauth
  attr_reader :auth

  def initialize(auth)
    @auth = auth
  end

  def call
    authorization= Authorization.where( provider: auth.provider,
                                        uid: auth.uid.to_s).first
    return authorization.user if authorization

    if auth.info[:email]
      email =  auth.info[:email]
    else
      return false
    end

    user = find_or_create_user(email)
    user.create_authorization(auth) if user
    user
  end

  def find_or_create_user(email)
    user = User.where(email: email).first
    unless user
      password = Devise.friendly_token[0,20]
      user = User.new(
        email: email,
        password: password,
        password_confirmation: password
        )
      if user.save!
        user
      else
        redirect_to new_user_session_path, message: "Something is going wrong"
      end
    end
  end
end

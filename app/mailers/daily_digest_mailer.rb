class DailyDigestMailer < ApplicationMailer
  def digest(user,questions)
    @greeting = "Hi"

    mail to:user.email
  end
end

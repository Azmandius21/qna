class DailyDigestMailer < ApplicationMailer
  def digest(user, _questions)
    @greeting = 'Hi'

    mail to: user.email
  end
end

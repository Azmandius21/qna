class NotifySubscribersMailer < ApplicationMailer
  def notify(user,answer)
    @greeting = "Hi"
    @user = user
    @answer = answer
    @question = @answer.question

    mail to: @user.email , subject: "The question #{@question.id} got a new"
  end
end

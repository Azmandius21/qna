class MailServices::NotifySubscribers
  def notify(answer)
    @question = answer.question
    @question.subscriptions.map do |s|
      NotifySubscribersMailer.notify(s.user, answer).deliver_later
    end
  end
end

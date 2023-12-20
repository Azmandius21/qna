class MailServices::DailyDigest
  def send_digest
    @new_questions = Question.last_day_questions.map{|q| q }

    User.find_each(batch_size: 500) do |user|
      DailyDigestMailer.digest(user,@new_questions).deliver_later
    end
  end
end

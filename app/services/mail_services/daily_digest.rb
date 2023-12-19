class MailServices::DailyDigest
  def send_digest
    User.find_each(batch_size: 500) do |user|
      DailyDigestMailer.digest(user,new_questions_ids).deliver_later
    end
  end

  private

  def new_questions_ids
    Question.where('created_at > ?', 1.day.ago).map{ |q| q.id }
  end
end

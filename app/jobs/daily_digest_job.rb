class DailyDigestJob < ApplicationJob
  queue_as :default

  def perform
    MailServices::DailyDigest.new.send_digest
  end
end

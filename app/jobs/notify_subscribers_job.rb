class NotifySubscribersJob < ApplicationJob
  queue_as :default

  def perform(object)
    MailServices::NotifySubscribers.new.notify(object)
  end
end

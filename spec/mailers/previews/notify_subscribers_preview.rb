# Preview all emails at http://localhost:3000/rails/mailers/notify_subscribers
class NotifySubscribersPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/notify_subscribers/notify
  def notify
    NotifySubscribersMailer.notify
  end
end

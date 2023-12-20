require 'rails_helper'

RSpec.describe MailServices::NotifySubscribers do
  let(:users){ create_list(:user, 3) }
  let(:question) { create(:question, author: users.first) }
  let(:answer) { create(:answer, question: question) }

  before do
    users.each do |user|
      Subscription.create(question: question, user: user)
    end
  end

  it 'send answer to all subscribed users' do
    users.each do |user|
      expect(NotifySubscribersMailer).to receive(:notify).with(user, answer).and_call_original
    end
    subject.notify(answer)
  end
end

require 'rails_helper'

RSpec.describe NotifySubscribersJob, type: :job do
  let(:service){ double('MailServices::NotifySubscribers') }
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  before do
    allow(MailServices::NotifySubscribers).to receive(:new).and_return(service)
  end

  it 'calls NotifySubscriptionMailer#deliver_now' do
    expect(service).to receive(:notify).with(answer)
    NotifySubscribersJob.perform_now(answer)
  end
end

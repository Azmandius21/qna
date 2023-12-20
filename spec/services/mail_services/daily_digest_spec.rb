require 'rails_helper'

RSpec.describe MailServices::DailyDigest do
  let!(:users){ create_list(:user, 3) }
  let!(:new_questions){ create_list(:question,4 , author: users.first) }
  let!(:old_questions){ create_list(:question, 3, author: users.first, created_at: 2.day.ago) }
  let(:questions) { Question.where('created_at > ?', 1.day.ago) }

  it 'send questions  all users' do
    users.each { |user| expect(DailyDigestMailer).to receive(:digest).with(user, questions).and_call_original }
    subject.send_digest
  end

  it 'send only created from the last 24 hours questions' do
    expect(questions.size).to eq 4
  end
end

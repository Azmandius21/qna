require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to :question }
  it { should have_many(:links).dependent(:destroy) }
  it { should accept_nested_attributes_for(:links).allow_destroy(true) }
  it { should validate_presence_of :body }
  it { should validate_presence_of :question_id }
  it { should validate_presence_of :author_id }

  it 'have many attached files' do
    expect(Answer.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
  end

  describe 'notify subscribers after create a new answer' do
    let(:question) { create(:question) }
    let(:answer) { build(:answer, question: question, author: create(:user)) }
    it 'calls NotifySubscribersJob' do
      expect(NotifySubscribersJob).to receive(:perform_later).with(answer)
      answer.save!
    end
  end
end

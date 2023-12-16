require 'rails_helper'

RSpec.describe ReputationJob, type: :job do
  describe 'reputation' do
    let(:question) { create(:question, author: create(:user)) }

    it 'calls ReputationJob' do
      expect(Calculation::Reputation).to receive(:calculate).with(question)
      ReputationJob.perform_now(question)
    end
  end
end

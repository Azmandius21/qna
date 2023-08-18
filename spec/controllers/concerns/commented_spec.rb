require 'rails_helper'

shared_examples 'commented' do
  let!(:user) { create(:user) }
  let!(:author) { create(:user) }
  let(:votable) { create(described_class.controller_name.classify.downcase.to_sym, author: author) }

  before { login(user) }

  describe '#comment', format: :js do
    it 'user comment on the votable' do
      patch :comment, params: { id: votable.id, format: :json }
      expect(votable.comments.count).to eq(1)
    end
  end

  describe '#delete_comment', format: :js do
    it 'user delete his comment' do
      patch :comment, params: { id: votable.id, format: :json }
      comment = votable.comments.take
      patch :delete_comment, params: { id: comment.id, format: :json }
      expect(votable.comments.count).to eq(0)
    end
  end
end

  

require 'rails_helper'

shared_examples 'commented' do
  let!(:user) { create(:user) }
  let!(:author) { create(:user) }
  let(:commentable) { create(described_class.controller_name.classify.downcase.to_sym, author: author) }

  before { login(user) }

  describe '#add_comment', format: :js do
    it 'user comment on the votable' do
      patch :add_comment, params: { id: commentable.id, body: 'My comment', user_id: user.id, format: :json }
      expect(commentable.comments.count).to eq(1)
    end
  end

  describe '#delete_comment', format: :js do
    it 'user delete his comment' do
      patch :add_comment, params: { id: commentable.id, body: 'My comment', user_id: user.id, format: :json }
      delete :delete_comment, params: { id: commentable.comments.last.id, format: :json }
      expect(commentable.comments.count).to eq(0)
    end
  end
end

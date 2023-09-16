require 'rails_helper'

shared_examples 'voted' do
  let!(:user) { create(:user) }
  let!(:author) { create(:user) }
  let(:votable) { create(described_class.controller_name.classify.downcase.to_sym, author: author) }

  before { login(user) }

  describe '#like', format: :js do
    it 'user voting for votable' do
      patch :like, params: { id: votable.id, format: :json }
      expect(votable.vote_sum).to eq(1)
    end
  end

  describe '#dislike', format: :js do
    it 'user voting for votable' do
      patch :dislike, params: { id: votable.id, format: :json }
      expect(votable.vote_sum).to eq(-1)
    end
  end

  describe '#reset_vote', format: :js do
    it 'user voting for votable' do
      patch :like, params: { id: votable.id, format: :json }
      patch :reset, params: { id: votable.id, format: :json }
      expect(votable.vote_sum).to eq(0)
    end
  end
end

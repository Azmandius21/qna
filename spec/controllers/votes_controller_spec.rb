require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  let!(:user) { create(:user) }
  let(:question) { create(:question) }
  
  before { login(user) }
  
  describe 'POST #create', format: :js do
    it 'user voting for question' do
      expect do
        post :create, params: { question_id: question, vote: { liked: true}, 
                                format: :json }
      end.to change(Vote, :count).by(1)
    end
  end

  describe 'DELETE #destroy', format: :js do
    it 'user reset his vote for question' do
      post :create, params: { question_id: question, vote: { liked: true}, 
                                format: :json }
      expect do
        delete :destroy, params: { id: Vote.take, format: :json }
      end.to change(Vote, :count).by(-1)
    end
  end
end
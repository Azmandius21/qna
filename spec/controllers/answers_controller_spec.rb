require 'rails_helper'
require 'byebug'

RSpec.describe AnswersController, type: :controller do
  describe 'POST #create' do
    let(:question) { create(:question) }
    let(:author) { create(:user) }

    before{ login(author) }

    context 'with valid attributes' do
      let(:answer) { attributes_for(:answer, question_id: question.id, author_id: author.id) }

      it 'save a new answer ' do
        expect do
          byebug
          post :create, params: { answer: answer }
        end.to change(Answer, :count).by(1)
      end

      it 'redirect to  show  a question' do
        post :create, params: { answer: answer }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid attributes' do
      let(:answer_attributes) { attributes_for(:answer, :invalid) }

      it 'does not save a new answer ' do
        expect do
          post :create, params: { question_id: question, answer: answer_attributes }
        end.to_not change(Answer, :count)
      end

      it 'redirect to  show  a question' do
        post :create, params: { question_id: question, answer: answer_attributes }
        expect(response).to redirect_to assigns(:question)
      end
    end
  end
end

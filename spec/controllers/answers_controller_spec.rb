require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'POST #create' do
    let(:question) { create(:question) }

    context 'with valid attributes' do
      let(:answer_attributes) { attributes_for(:answer) }

      it 'save a new answer ' do
        expect do
          post :create, params: { question_id: question, answer: answer_attributes }
        end.to change(Answer, :count).by(1)
      end

      it 'redirect to  show  a new answer' do
        post :create, params: { question_id: question, answer: answer_attributes }
        expect(response).to redirect_to assigns(:answer)
      end
    end

    context 'with invalid attributes' do
      let(:answer_attributes) { attributes_for(:answer, :invalid) }

      it 'does not save a new answer ' do
        expect do
          post :create, params: { question_id: question, answer: answer_attributes }
        end.to_not change(Answer, :count)
      end

      it 'render template new' do
        post :create, params: { question_id: question, answer: answer_attributes }
        expect(response).to render_template :new
      end
    end
  end
end

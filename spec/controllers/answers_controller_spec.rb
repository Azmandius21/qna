require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, author_id: user.id) }

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      let(:answer_attributes) { attributes_for(:answer) }

      it 'save a new answer ' do
        expect do
          post :create, params: { question_id: question, author_id: user, answer: answer_attributes }
        end.to change(Answer, :count).by(1)
      end

      it 'redirect to  show  a question' do
        post :create, params: { question_id: question, author_id: user, answer: answer_attributes }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid attributes' do
      let(:answer_attributes) { attributes_for(:answer, :invalid) }

      it 'does not save a new answer ' do
        expect do
          post :create, params: { question_id: question, author_id: user, answer: answer_attributes }
        end.to_not change(Answer, :count)
      end

      it 'redirect to  show  a question' do
        post :create, params: { question_id: question, author_id: user, answer: answer_attributes }
        expect(response).to redirect_to assigns(:question)
      end
    end
  end

  describe 'GET #show' do
    let(:answer) { create(:answer, question_id: question.id, author_id: user.id) }

    before { get :show, params: { id: answer } }

    it 'assign the requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'render show answer template' do
      expect(response).to render_template :show
    end
  end

  describe 'DELETE #destroy' do
    let!(:answer) { create(:answer, question_id: question.id, author_id: user.id) }

    before { login(user) }

    it 'delete the answer' do
      expect do
        delete :destroy, params: { id: answer }
      end.to change(Answer, :count).by(-1)
    end

    it 'redirect to questions#index' do
      delete :destroy, params: { id: answer }
      expect(response).to redirect_to question_path(question)
    end
  end
end

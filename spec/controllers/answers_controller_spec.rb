require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'POST #create' do
    let(:question) { create(:question) }
    let(:user) { create(:user) }

    before{ login(user) }

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
          post :create, params: { question_id: question, author_id: user,answer: answer_attributes }
        end.to_not change(Answer, :count)
      end

      it 'redirect to  show  a question' do
        post :create, params: { question_id: question, author_id: user, answer: answer_attributes }
        expect(response).to redirect_to assigns(:question)
      end
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:question) { create(:question, author_id: user.id) }
    let(:answer) { create(:answer, question_id: question.id,  author_id: user.id) }

    before { get :show, params: { id: answer } }
    
    it 'assign the requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'render show answer template' do
      expect(response).to render_template :show
    end
  end
end

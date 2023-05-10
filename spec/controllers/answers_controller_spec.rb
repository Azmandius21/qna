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
          post :create, params: { question_id: question, author_id: user, answer: answer_attributes },
                        format: :js
        end.to change(Answer, :count).by(1)
      end

      it 'render  #create answer' do
        post :create, params: { question_id: question, author_id: user, answer: answer_attributes },
                      format: :js
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      let(:answer_attributes) { attributes_for(:answer, :invalid) }

      it 'does not save a new answer ' do
        expect do
          post :create, params: { question_id: question, author_id: user, answer: answer_attributes },
                        format: :js
        end.to_not change(Answer, :count)
      end

      it 'render #create answer' do
        post :create, params: { question_id: question, author_id: user, answer: answer_attributes },
                      format: :js
        expect(response).to render_template :create
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

  describe 'PATCH #update' do
    let(:answer) { create(:answer, question: question, author: user) }

    before { login(user) }

    context 'With valid attributes' do
      it 'update the answer' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'render update view' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
        expect(response).to render_template :update
      end
    end

    context 'With invalid attributes' do
      it ' does not change answer' do
        expect do
          patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js
        end.to_not change(answer, :body)
      end

      it 'render update view' do
        patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js
        expect(response).to render_template :update
      end
    end
  end

  describe 'PATCH #select' do
    let!(:answer) { create(:answer, question: question, author: user)}

    before { login(user) }

    it 'select answer like best for current question' do
      patch :select, params: { id: answer}, format: :js
      expect(question.best_answer.question).to eq answer.question
    end
  end
end

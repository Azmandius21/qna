require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:questions) { create_list(:question, 3) }
  let(:user) { create(:user) }

  describe 'GET #index' do
    before { get :index }

    it 'populate an array of questions' do
      expect(assigns(:questions)).to match_array(questions)
    end
  end

  describe 'GET #new' do
    before { login(user) }
    before { get :new }

    it 'render template new' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      let(:question) { attributes_for(:question, author_id: user) }

      it 'saves a new questions' do
        expect do
          post :create, params: { question: question }
        end.to change(Question, :count).by(1)
      end

      it 'redirect to show view' do
        post :create, params: { question: question }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with not valid attributes' do
      let(:question) { attributes_for(:question, :invalid) }

      it 'does not save a new questions' do
        expect do
          post :create, params: { question: question }
        end.to_not change(Question, :count)
      end

      it 'render a new_question template' do
        post :create, params: { question: question }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    before { login(user) }

    let!(:question) { create(:question, author_id: user.id) }

    it 'delete the question' do
      expect do
        delete :destroy, params: { id: question }
      end.to change(Question, :count).by(-1)
    end

    it 'redirect to questions#index' do
      delete :destroy, params: { id: question }
      expect(response).to redirect_to questions_path
    end
  end
end

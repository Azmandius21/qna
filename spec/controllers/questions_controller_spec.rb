require 'rails_helper'
require_relative './concerns/voted_spec'

RSpec.describe QuestionsController, type: :controller do
  it_behaves_like 'voted'

  let(:user) { create(:user) }
  let(:not_author) { create(:user) }
  let(:questions) { create_list(:question, 3) }
  let(:question) { create(:question, author: user) }
  let(:answer) { create(:answer, question: question) }

  describe 'GET #index' do
    before { get :index }

    it 'populate an array of questions' do
      expect(assigns(:questions)).to match_array(questions)
    end
  end

  describe 'GET #new' do
    before { login(user) }
    before { get :new }

    it 'assign a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'assign a new Question to @question' do
      expect(assigns(:question).links.first).to be_a_new(Link)
    end

    it 'render template new' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    let(:question_attr) { attributes_for(:question, author: user) }

    before { login(user) }

    context 'with valid attributes' do
      it 'saves a new questions' do
        expect do
          post :create, params: { question: question_attr }
        end.to change(Question, :count).by(1)
      end

      it 'broadcast new question' do
        expect { post :create, params: { question: question_attr}}.to(
         have_broadcasted_to("questions_channel").with(  question_attr )
        )
      end

      it 'redirect to show view' do
        post :create, params: { question: question_attr }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with not valid attributes' do
      let(:question_attr) { attributes_for(:question, :invalid) }

      it 'does not save a new questions' do
        expect do
          post :create, params: { question: question_attr }
        end.to_not change(Question, :count)
      end

      it 'render a new_question template' do
        post :create, params: { question: question_attr }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    before { login(user) }

    it 'delete the question' do
      question
      expect do
        delete :destroy, params: { id: question }
      end.to change(Question, :count).by(-1)
    end

    it 'redirect to questions#index' do
      delete :destroy, params: { id: question }
      expect(response).to redirect_to questions_path
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'assigns the requested question as @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns  new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'assigns  new links for answer' do
      expect(assigns(:answer).links.first).to be_a_new(Link)
    end

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'PATCH #update' do
    before { login(user) }

    context 'with valid attributes' do
      it 'update question body' do
        # login(user)
        patch :update, params: { id: question, question: { title: 'new title', body: 'new body' } }, format: :js
        question.reload
        expect(question.body).to eq 'new body'
      end

      it 'render template update' do
        patch :update, params: { id: question, question: { body: 'new body' } }, format: :js
        expect(response).to render_template :update
      end
    end

    context 'with invalid attributes' do
      it 'can not change question' do
        expect do
          patch :update, params: { id: question, question: attributes_for(:question, :invalid) }, format: :js
          question.reload
        end.to_not change(question, :body)
      end

      it 'render show template' do
        patch :update, params: { id: question, question: attributes_for(:question, :invalid) }, format: :js
        question.reload
        expect(response).to render_template :update
      end
    end

    it 'not an author can\'t change question' do
      login(not_author)
      expect do
        patch :update, params: { id: question, question: { body: 'new body' } }, format: :js
        question.reload
      end.to_not change(question, :body)
    end
  end
end

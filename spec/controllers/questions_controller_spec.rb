require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  describe 'GET #index' do
    let(:questions){ create_list(:question, 3)}

    before { get :index}
    
    it 'populate an array of questions' do
      expect(assigns(:questions)).to match_array(questions)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:question){ attributes_for(:question)}

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
      let(:question){ attributes_for(:question, :invalid)}
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
end

require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
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

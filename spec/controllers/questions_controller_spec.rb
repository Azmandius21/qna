require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves a new questions' do
        expect { post :create, params: {question: attributes_for(:question)}}.to change(Question, :count).by(1)
      end

      it 'redirect to show view' do
        post :create, params: {question: attributes_for(:question)}
        expect(response).to redirect_to assigns(:question)
      end
    end
    context 'with not valid attributes' do
      it 'dose not save a new questions' do
        expect { post :create, params: {question: attributes_for(:question, :invalid)}}.to_not change(Question, :count)
      end

      it 'render template new'do
        post :create, params: {question: attributes_for(:question, :invalid)}
        expect(response).to render_template :new 
      end
    end
  end
end

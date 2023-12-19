require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  describe "POST #create" do
    let(:user){ create(:user) }
    let(:question) { create(:question) }

    before { login user }

    it "create new Subscription" do
      expect do
        post :create , params: { question_id: question.id }, format: :js
      end.to change(Subscription, :count).by(1)
    end


  end

  describe "DELETE #destroy" do
    let(:user){ create(:user) }
    let!(:subscription) { create(:subscription) }

    context 'authenticated user' do
      before { login user }

      it "destroy the subscription" do
        expect do
          delete :destroy, params: { id: subscription.id }, format: :js
        end.to change(Subscription, :count).by(-1)
      end
    end

    context 'unauthenticated user' do
      it "trys destroy the subscription" do
        expect do
          delete :destroy, params: { id: subscription.id }, format: :js
        end.to_not change(Subscription, :count)
      end
    end
  end
end

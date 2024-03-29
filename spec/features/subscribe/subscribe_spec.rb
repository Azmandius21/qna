require 'rails_helper'

feature 'User can subscribe to a question', "
  In order to now about changes with the question
  As an authenticated User
  I'd like be able subscribe on the question
" do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe 'authenticated users' do
    scenario 'user is able to subscribe to the question ', js: true do
      sign_in(user)

      visit question_path(question)
      expect(page).to have_link 'Subscribe'
    end
  end

  describe 'unauthenticated users', js: true do
    scenario 'try subscribe to the question ' do
      visit question_path(question)

      expect(page).to_not have_link 'Subscribe'
      expect(page).to_not have_link 'Unsubscribe'
    end
  end
end

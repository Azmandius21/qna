require 'rails_helper'

feature 'User can create a vote', "
  In order to like(or dislike) to votavle
  As an authenticated User
  I'd like to be able to take my vote
" do
  describe 'Authenticated user try to vote for question' do
    given!(:user) { create(:user) }
    given!(:author) { create(:user) }
    given(:question) { create(:question, author: author) }
    scenario 'User not author of question', js: :true do
      sign_in(user)
      visit question_path(question)
      click_on 'Like'

      expect(page).to have_link 'Reset vote'
    end

    scenario 'Author of question', js: :true do
      sign_in(author)
      visit question_path(question)

      expect(page).to_not have_link 'Like'
    end

    scenario 'only one vote from usser to current question', js: :true do
      sign_in(user)
      visit question_path(question)
      click_on 'Like'

      expect(page).to_not have_link 'Like'
      expect(page).to_not have_link 'Dislike'
    end
  end
end

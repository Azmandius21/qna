require 'rails_helper'

feature 'User can edit question ', "
  In order to edit oun question
  As authenticated user
  From page current question
  I'd like to be able to edit an question
" do
  given!(:author) { create(:user) }
  given!(:question) { create(:question, author: author) }

  describe 'Authenticated user try edit his question ', js: true do
    background { sign_in(author) }

    scenario 'with valid data' do
      visit questions_path
      click_on 'Edit'
      fill_in 'question_body', with: 'New question body'
      fill_in 'question_title', with: 'New question title'
      click_on 'Save'

      within '.questions' do
        expect(page).to have_content 'New question body'
        expect(page).to have_content 'New question title'
      end
    end

    scenario 'with invalid data' do
      visit questions_path
      click_on 'Edit'
      fill_in 'question_body', with: ''
      fill_in 'question_title', with: ''
      click_on 'Save'

      within '.questions' do
        expect(page).to have_content "Title can't be blank"
        expect(page).to have_content "Body can't be blank"
      end
    end
  end
end

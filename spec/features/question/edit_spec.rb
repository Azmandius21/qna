require 'rails_helper'

feature 'User can edit question ', "
  In order to edit oun question
  As authenticated user
  From page current question
  I'd like to be able to edit an question
" do
  given(:author){ create(:user) }
  given(:question){ create(:question, author_id: author.id) }
  describe 'Authenticated user try edit his question ', js: true do
    scenario 'with valid data' do
      visit question_path(question)
      click_on 'Edit question'
      fill_in 'Body', with: 'New question body'
      fill_in 'Title', with: 'New question title'
      click_on 'Edit'

      within '.question' do
        expect(page).to have_content 'New question body'
        expect(page).to have_content 'New question title'
      end
    end
  end
end
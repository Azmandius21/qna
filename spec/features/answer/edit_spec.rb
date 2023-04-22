require 'rails_helper'

feature 'User can edit his answer', "
  In order to correct mistakes
  From the page of current question
  As an author of answer
  I'd like be able to edit my answer
" do

given!(:author){ create(:user) }
given!(:question){ create(:question, author: author)}
  given!(:answer){ create(:answer, question: question, author: author)}

  scenario 'Unauthenticated can not edit answer', js: true do
    visit question_path(question)

    expect(page).to_not have_link 'Edit answer'
  end

  describe 'Authenticated user' do    
    scenario 'Edit his answer', js: true do
      sign_in(author)
      visit question_path(question)
      
      click_on 'Edit answer'
      within '.answers' do
        fill_in 'Body', with: 'Edited answer'
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'Edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end
    scenario 'Edit his answer with errors'
    scenario 'Edit other user answer' 
  end
end

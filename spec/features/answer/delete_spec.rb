require 'rails_helper'

feature 'User can delete an answer', "
  In order to delete my answer
  As an authenticated User
  I'd like ba able to delete only my answer
" do
  given(:author) { create(:user) }
  given!(:question) { create(:question, author: author) }
  given!(:answer) { create(:answer, question: question, author: author) }
  given(:user) { create(:user) }

  scenario 'Author delete only his answer', js: true do
    sign_in(author)
    visit question_path(question)
    save_and_open_page
    
    click_on 'Delete answer'
    expect(page).to have_content 'The answer deleted successfully.'
    expect(page).to_not have_content answer.body
  end

  scenario 'User tries delete question from another author', js: true do
    sign_in(user)
    visit question_path(question)
    expect(page).to_not have_content 'Delete'
  end
end

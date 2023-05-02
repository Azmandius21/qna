require 'rails_helper'

feature 'User can delete a question', "
  In order to delete my question
  As an authenticated User
  I'd like ba able to delete only my questions
" do
  given!(:author) { create(:user) }
  given!(:question) { create(:question, author_id: author.id) }

  scenario 'Author delete only his question', js: true do
    sign_in(author)
    visit questions_path
    click_on 'Delete'
    expect(page).to_not have_content question.title
    expect(page).to_not have_content question.body
  end

  given(:user) { create(:user) }

  scenario 'User tries delete question from another author' do
    sign_in(user)
    visit question_path(question)

    expect(page).to_not have_button 'Delete'
  end
end

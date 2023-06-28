require 'rails_helper'

feature 'users can vote for qustions', "
In order to vote for question
As an authenticated User
I'd like be able to vote for question
" do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'an authenticated user able to vote for question', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Like'

    expect(page).to have_link 'Reset vote'
  end
end
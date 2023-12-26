require 'rails_helper'
require 'byebug'

feature 'Author subscribe to a question after create it', "
  In order to now about changes with the question
  As an author the question
  I'd like be able auto-subscribe on the question after create it
" do
  given(:author) { create(:user) }

  background do
    sign_in(author)

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'
    click_on 'Ask'
  end

  scenario 'create and subscribe to the question ' do
    expect(page).to have_link 'Unsubscribe'
  end

  scenario 'author can unsubdcribe on the question', js: true do
    click_on 'Unsubscribe'

    expect(page).to have_link 'Subscribe'
  end
end

require 'rails_helper'

feature 'Author subscribe to a question after create it', "
  In order to now about changes with the question
  As an author the question
  I'd like be able auto-subscribe on the question after create it
" do
  given(:author) { create(:user) }

  scenario 'create and subscribe to the question ' do
    sign_in(author)

    visit questions_path
    click_on 'Ask question'

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'
    click_on 'Ask'

    visit question_path(Question.last)

    expect(page).to have_link 'Unsubscribe'
  end
end

require 'sphinx_helper'

feature 'User can search for question', "
  In order to find needed question
  As a User
  I'd like to be able to search for the question
" do

  describe 'User search for the question', js: true do
    given(:author){ create(:user, email: 'question@test.ru')}
    given(:question1) do
      create(:question, title: 'find in body', body: 'question body')
    end
    given(:question2) do
      create(:question, title: 'question title', body: 'find in title')
    end
    given(:question3) do
      create(:question, author: author, title: 'title3', body: 'find in author email')
    end
  end

  scenario 'data present', sphinx: true do
    ThinkingSphinx::Test.run do
      visit questions_path

      within '.global-search' do
        fill_in 'search', with: "question"
        check 'by_questions'
        click_on 'Find'
      end

      within 'result-search' do
        expect(page).to have_content 'find in body'
        expect(page).to have_content 'find in title'
        expect(page).to have_content 'find in author email'
      end
   end
  end

  scenario 'empty result', sphinx: true do
    ThinkingSphinx::Test.run do
      visit questions_path

      within '.global-search' do
        fill_in 'search', with: "empty"
        check 'by_questions'
        click_on 'Find'
      end

      within 'result-search' do
        expect(page).to have_content 'Nothing found'
      end
   end
  end
end

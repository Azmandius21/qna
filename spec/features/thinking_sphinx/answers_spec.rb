require 'sphinx_helper'
feature 'User can search for answer', "
  In order to find needed answer
  As a User
  I'd like to be able to search for the answer
" do
  describe 'User search for the answer', js: true do
    given!(:author) { create(:user, email: 'sphinx@test.ru') }
    given!(:answer1) { create(:answer, body: 'find in body sphinx') }
    given!(:answer2){ create(:answer, author: author, body: 'find in author email')}

    background { visit questions_path }

    scenario 'Content has query items', sphinx: true do
      ThinkingSphinx::Test.run do
        within '.search' do
          fill_in 'query', with: 'sphinx'
          select_by_value 'search_area', 'answer'
          click_on 'Find'
        end

        within '.result-search' do
          expect(page).to have_content 'find in body'
          expect(page).to have_content 'find in author email'
        end
      end
    end

    scenario 'Content has not query items', sphinx: true do
      ThinkingSphinx::Test.run do
        within '.search' do
          fill_in 'query', with: 'empty'
          select_by_value 'search_area', 'answer'
          click_on 'Find'
        end

        within '.result-search' do
          expect(page).to have_content 'No items found'
        end
      end
    end
  end
end

require 'sphinx_helper'
feature 'User can search for comment', "
  In order to find needed comment
  As a User
  I'd like to be able to search for the comment
" do
  describe 'User search for the comment', js: true do
    given!(:author) { create(:user, email: 'sphinx@test.ru') }
    given!(:question) { create(:question) }
    given!(:comment1) { create(:comment, commentable: question, body: 'find in body sphinx') }
    given!(:comment2) { create(:comment, commentable: question, user: author, body: 'find in author email') }

    background { visit questions_path }

    scenario 'Content has query items', sphinx: true do
      ThinkingSphinx::Test.run do
        within '.search' do
          fill_in 'query', with: 'sphinx'
          select_by_value 'search_area', 'comment'
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
          select_by_value 'search_area', 'comment'
          click_on 'Find'
        end

        within '.result-search' do
          expect(page).to have_content 'No items found'
        end
      end
    end
  end
end

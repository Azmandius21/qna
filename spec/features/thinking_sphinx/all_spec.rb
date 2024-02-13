require 'sphinx_helper'
feature 'User can search for all', "
  In order to find needed any thing
  As a User
  I'd like to be able to search for all
" do
  describe 'User search for all content', js: true do
    given!(:user) { create(:user, email: 'find_in_user@sphinx.ru') }
    given!(:question) { create(:question, title: 'find in question', body: 'sphinx') }
    given!(:answer) { create(:answer, body: 'find in answer sphinx') }
    given!(:comment) { create(:comment, commentable: question, body: 'find in comment sphinx') }

    background { visit questions_path }

    scenario 'Content has query items', sphinx: true do
      ThinkingSphinx::Test.run do
        within '.search' do
          fill_in 'query', with: 'sphinx'
          select_by_value 'search_area', 'all'
          click_on 'Find'
        end

        within '.result-search' do
          expect(page).to have_content 'find in question'
          # expect(page).to have_content 'find in answer'
          # expect(page).to have_content 'find in comment'
          expect(page).to have_content 'find_in_user'
        end
      end
    end

    scenario 'Content has not query items', sphinx: true do
      ThinkingSphinx::Test.run do
        within '.search' do
          fill_in 'query', with: 'empty'
          select_by_value 'search_area', 'all'
          click_on 'Find'
        end

        within '.result-search' do
          expect(page).to have_content 'No items found'
        end
      end
    end
  end
end

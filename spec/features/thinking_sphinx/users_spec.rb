require 'sphinx_helper'
feature 'User can search for user', "
  In order to find needed user
  As a User
  I'd like to be able to search for the user
" do
  describe 'User search for the user', js: true do
    given!(:user) { create(:user, email: 'find_in_email@sphinx.ru') }

    background { visit questions_path }

    scenario 'Content has query items', sphinx: true do
      ThinkingSphinx::Test.run do
        within '.search' do
          fill_in 'query', with: 'sphinx'
          select_by_value 'search_area', 'user'
          click_on 'Find'
        end

        within '.result-search' do
          expect(page).to have_content 'find_in_email'
        end
      end
    end

    scenario 'Content has not query items', sphinx: true do
      ThinkingSphinx::Test.run do
        within '.search' do
          fill_in 'query', with: 'empty'
          select_by_value 'search_area', 'user'
          click_on 'Find'
        end

        within '.result-search' do
          expect(page).to have_content 'No items found'
        end
      end
    end
  end
end

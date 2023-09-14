require 'rails_helper'

feature 'Comments for question', "
  In order to translate self appinion about resource
  As authenticated user
  I'd like to be able to add/change/remove comment
" do

    given!(:question_author){ create(:user) }
    given!(:question){ create(:question, author: question_author) }
    given!(:user){ create(:user) }
    given!(:someone){ create(:user) }
    given!(:unuthenticated_user){ create(:user) }

    
    describe 'authenticated user' do
      background do
        sign_in(user)
        visit question_path(question)
      end
    
      scenario 'add Comment' do
        within '.new-comment' do
          fill_in 'Your Comment', with: 'My Comment is my appinion'
          click_on 'Comment'  
        end          
        
        within '.comments-list' do
          expect(page).to have_content 'My Comment is my appinion'
        end
      end
    end
      
    describe 'unauthenticated user' do
      scenario 'trys to add Comment' do
        within '.new-comment' do
          expect(page).to_not has_selector?('new-comment')  
        end          
      end
    end   
end

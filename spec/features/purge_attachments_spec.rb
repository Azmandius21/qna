require 'rails_helper'

feature 'purge attachment', "
  In order to prune attacments in resource 
  As an author of resource( question, answer)
  I'd like to be able purge correct attachment
" do
  given!(:author){ create(:user) }
  given!(:question){ create(:question, :with_attached_files, author: author) }
  
  describe 'purge attached file to question' do
    scenario 'authenticated author of question try' do
      sign_in(author)
      visit questions_path

      click_on 'Remove file'
      expect(page).to_not have_link 'test-image.png'
    end

    scenario 'authenticated not author try'

    scenario 'unauthenticated user try'
  end

  describe 'purge attached file to answer' do
    scenario 'authenticated author of answer try' 

    scenario 'authenticated not author try'
    
    scenario 'unauthenticated user try'
  end 
end
require 'rails_helper'

feature 'purge attachment', "
  In order to prune attacments in resource
  As an author of resource( question, answer)
  I'd like to be able to purge my attachment
" do
  given!(:author) { create(:user) }
  given(:not_author) { create(:user) }
  given!(:question) { create(:question, :with_attached_files, author: author) }
  given!(:answer) { create(:answer, :with_attached_files, question: question, author: author) }

  describe 'purge attached file' do
    context 'author tries' do
      background { sign_in(author) }

      scenario 'to purge attached file on question ' do
        visit questions_path

        click_on 'Remove file'
        expect(page).to_not have_link 'test-image.png'
      end

      scenario 'to purge attached file on answer' do
        visit question_path(question)

        within '.answers' do
          click_on 'Remove file'
          expect(page).to_not have_link 'test-image.png'
        end
      end
    end

    context 'not author tries' do
      background { sign_in(not_author) }

      scenario 'to purge attached file on question' do
        visit questions_path

        expect(page).to_not have_link 'Remove file'
      end

      scenario 'to purge attached file on answer' do
        visit question_path(question)

        within '.answers' do
          expect(page).to_not have_link 'Remove file'
        end
      end
    end

    context 'unauthenticated user tries' do
      scenario 'to purge attached file on question' do
        visit questions_path

        expect(page).to have_link 'test-image.png'
        expect(page).to_not have_link 'Remove file'
      end

      scenario 'to purge attached file on answer' do
        visit question_path(question)

        within '.answers' do
          expect(page).to have_link 'test-image.png'
          expect(page).to_not have_link 'Remove file'
        end
      end
    end
  end
end

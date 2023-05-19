require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let(:author) { create(:user) }
  let(:question) { create(:question, :with_attached_files, author: author) }

  describe 'DELETE #purge' do
    before { login(author) }

    it 'purge one files in questions.files' do
      attachment_id = question.files.first.id

      expect do
        delete :purge, params: { id: attachment_id }
      end.to change(ActiveStorage::Attachment, :count).by(-1)
    end
  end
end

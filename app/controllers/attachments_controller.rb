class AttachmentsController < ApplicationController
  def purge
    @attachment = ActiveStorage::Attachment.find(params[:id])
    @attachment.purge
    redirect_to questions_path
  end
end

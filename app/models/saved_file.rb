class SavedFile < ApplicationRecord

  mount_uploader :attachment, AttachmentUploader

  belongs_to :user
  belongs_to :saved_file_category

  scope :created_at_desc, -> { order(arel_table[:created_at].desc) }

  def to_jq_upload
    {
      'name' => attachment.filename || "Attachment#{id}",
      'size' => attachment.size,
      'url' => attachment.url,
      'deleteUrl' => "/saved_files/#{id}",
      'deleteType' => 'DELETE'
    }
  end


end

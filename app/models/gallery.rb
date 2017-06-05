class Gallery < ApplicationRecord
	mount_uploader :attachment, AttachmentUploader
	validates :name, presence: {message: "Please enter name."}
  validates :name, uniqueness: {message: " Name already taken" }
  validates :attachment, presence: {message: "Please attach image."}
  validates :name, :format => { :with => /\A[A-Za-z ][A-Za-z ]*\z/,:message => "Only letters allowed" }

  require 'csv'

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
    	gallery = Gallery.new
    	gallery.name = row['name']
    	gallery.remote_attachment_url = row['img_url']
    	if gallery.save
        return "success"
      else
        return invalid.record.errors
      end
    end
  end

end

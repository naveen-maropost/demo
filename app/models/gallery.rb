class Gallery < ApplicationRecord
	 mount_uploader :attachment, AttachmentUploader
end

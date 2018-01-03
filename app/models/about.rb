class About < ApplicationRecord
  self.table_name = 'about'
  mount_uploader :resume_file, ResumeUploader # Tells rails to use this uploader for this model.
end

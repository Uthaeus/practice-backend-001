class Project < ApplicationRecord
    validates_presence_of :title, :description, :link

    mount_uploader :thumb_image, ProjectUploader
    mount_uploader :main_image, ProjectUploader
end

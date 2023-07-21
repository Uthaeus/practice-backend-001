class Blog < ApplicationRecord
  belongs_to :Topic

  validates_presence_of :title, :body
end

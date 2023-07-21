class Blog < ApplicationRecord
  belongs_to :topic

  validates_presence_of :title, :body
end

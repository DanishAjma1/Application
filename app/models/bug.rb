class Bug < ApplicationRecord
  belongs_to :project

  validates :title, :description, :priority, presence: true
  belongs_to :qa, class_name: "User", foreign_key: "qa_id"
  has_and_belongs_to_many :developer, class_name: "User"
end

class Bug < ApplicationRecord
  belongs_to :project

  enum priority: { low: 0, medium: 1, high: 2, critical: 3 }

  validates :title, :status, :priority, presence: true
end

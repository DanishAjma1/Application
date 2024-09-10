class Project < ApplicationRecord
    belongs_to :manager, class_name: "User", foreign_key: "manager_id"
    has_and_belongs_to_many :qa, class_name: "User", dependent: :destroy
    has_many :bugs, dependent: :destroy
end

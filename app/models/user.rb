class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  validates :role, presence: true, inclusion: { in: %w[manager qa developer] }

  # Optional: Use enums for roles
  enum role: { manager: 1, qa: 2, developer: 3 }

  has_many :managed_projects, class_name: "Project", foreign_key: "manager_id"
  has_and_belongs_to_many :assigned_projects, class_name: "Project", dependent: :destroy
  has_many :created_bugs, class_name: "Bug", foreign_key: "qa_id"
  has_and_belongs_to_many :assigned_bugs, class_name: "Bug"
end

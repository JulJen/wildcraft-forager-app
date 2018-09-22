class TeamMember < ApplicationRecord
  belongs_to :project, optional: true
  has_many :teams, through: :projects

  # include ActiveModel::Validations

  # validates :user_id, presence: true
  # validates :email, presence: true

  # validates :team_id, presence: true
  # validates :project_id, presence: true
  # validates_uniqueness_of :name

end

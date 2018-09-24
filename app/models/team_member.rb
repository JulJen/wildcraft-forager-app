class TeamMember < ApplicationRecord
  belongs_to :project, optional: true
  has_many :teams, through: :projects

  include ActiveModel::Validations

  validates :user_id, presence: true

end 

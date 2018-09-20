class Project < ApplicationRecord
  belongs_to :team, optional: true
  belongs_to :user, optional: true
  has_many :team_members

  include ActiveModel::Validations

  validates :name, presence: true
  validates :description, :presence => true
end

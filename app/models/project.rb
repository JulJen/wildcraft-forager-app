class Project < ApplicationRecord
  belongs_to :team, optional: true

  has_many :users, through: :teams

  has_many :team_members


  include ActiveModel::Validations

  validates :name, presence: true
  validates :description, :presence => true
end

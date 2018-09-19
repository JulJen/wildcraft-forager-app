class Team < ApplicationRecord
  belongs_to :user, optional: true
  has_many :projects
  has_many :team_members, through: :projects

  # # testing these out
  # has_many :projects
  # belongs_to :user
  # has_many :projects, through: :users

  # has_many :users, through: :projects

  include ActiveModel::Validations

  validates :name, presence: true
  validates_uniqueness_of :name


end

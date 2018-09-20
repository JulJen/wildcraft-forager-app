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

  validate :ensure_unique, on: :create

  # validates :team_admin, inclusion: { in: [ true, 'true' ] }

  # validates_inclusion_of :team_admin, :in => [true, false]
  # validates :team_admin, :presence => { :message => "Please select some formats!" }
  # validates :team_admin, acceptance: {accept: true} , on: :create, allow_nil: false
  validates :team_admin, :inclusion => {:in => [true, false]}, presence: true

end

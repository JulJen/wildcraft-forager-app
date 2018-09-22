class Team < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :industry, optional: true

  has_many :projects
  has_many :team_members, through: :projects

  include ActiveModel::Validations

  validates :name, presence: true
  validates :name, uniqueness: true
  
  validates :category, presence: true

  validates :team_admin, :inclusion => {:in => [true, false]}

  # validates :user,
  #   uniqueness: {
  #     message: ->(object, data) do
  #       "Hey #{object.name}!, #{data[:value]} is taken already!"
  #     end
  #   }

  # validates :team_admin, inclusion: { in: [ true, 'true' ] }

  # validates_inclusion_of :team_admin, :in => [true, false]
  # validates :team_admin, acceptance: {accept: true} , on: :create, allow_nil: false


end

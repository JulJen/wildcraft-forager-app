class Team < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :industry, optional: true

  scope :ordered_by_industry, -> { order(industry: :asc) }

  has_many :projects
  has_many :team_members, through: :projects

  include ActiveModel::Validations

  validates :name, presence: true
  validates :name, uniqueness: true

  validates :category, presence: true

  validates :team_admin, :inclusion => {:in => [true, false]}

  def self.show_team(name)
    name.gsub(/"|\[|\]/, '').upcase
  end

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

class Project < ApplicationRecord #formerly team
  has_many :memberships
  has_many :users, through: :memberships

  has_many :posts

  include ActiveModel::Validations

  validates :name, presence: true
  validates :name, uniqueness: true

  # validates :category_id, presence: true

  def team_category
    Category.find(self.team_id).industry_name
  end



  # def self.show_team(name)
  #   name.gsub(/"|\[|\]/, '').capitalize
  # end

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

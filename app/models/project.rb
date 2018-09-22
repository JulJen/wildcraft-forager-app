class Project < ApplicationRecord
  belongs_to :team, optional: true
  belongs_to :industry, optional: true

  has_many :users, through: :teams

  has_many :team_members

  # scope :member_info, -> {
  #       where(id: TeamMember.pluck(:user_id)) }
  #

  include ActiveModel::Validations

  validates :name, presence: true
  validates :description, :presence => true

  def name=(new_name)
  write_attribute(:name, new_name.upcase)
  # This is equivalent: self[:name] = new_name.upcase
  end

  
end

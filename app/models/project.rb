class Project < ApplicationRecord
  belongs_to :team, optional: true
  belongs_to :industry, optional: true

  has_many :users, through: :teams
  has_many :team_members

  # scope :user_comments, -> { where(published: true) }
  # scope :featured, -> { where(featured: true) }
  #
  # def self.latest_project_comment
  #
  # end

  include ActiveModel::Validations

  validates :name, presence: true
  validates :description, :presence => true


end

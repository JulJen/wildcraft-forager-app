class Project < ApplicationRecord
  belongs_to :team
  has_many :users, through: :teams
  # belongs_to :user

  include ActiveModel::Validations

  validates :name, presence: true
  validates_uniqueness_of :name

end

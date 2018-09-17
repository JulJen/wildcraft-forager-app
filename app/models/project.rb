class Project < ApplicationRecord
  belongs_to :team, optional: true
  has_many :users, through: :teams


  include ActiveModel::Validations

  validates :name, presence: true
  validates_uniqueness_of :name

end

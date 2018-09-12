class Team < ApplicationRecord
  has_many :users
  has_many :projects, through: :users

  validates :name, presence: true
  validates_uniqueness_of :name
  validates :name, length: { in: 6..20}

end

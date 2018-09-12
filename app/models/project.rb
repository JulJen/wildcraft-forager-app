class Project < ApplicationRecord
  belongs_to :team
  belongs_to :user

  validates :name, presence: true
  validates_uniqueness_of :name
  validates :name, length: { in: 6..20}

end

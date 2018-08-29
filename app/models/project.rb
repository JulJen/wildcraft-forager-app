class Project < ApplicationRecord
  belongs_to :team
  has_many :users, through: :teams

end

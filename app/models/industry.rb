class Industry < ApplicationRecord
  has_many :teams

  has_many :users, through: :teams

  has_many :projects, through: :teams

  has_many :team_members, through: :projects

end

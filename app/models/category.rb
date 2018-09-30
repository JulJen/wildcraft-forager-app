class Category < ApplicationRecord
  has_many :teams

  include ActiveModel::Validations

  validates :industry_name, presence: true

end

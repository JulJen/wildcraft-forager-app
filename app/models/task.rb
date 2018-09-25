class Task < ApplicationRecord
  belongs_to :project, optional: true
  belongs_to :user, optional: true

  include ActiveModel::Validations

  validates :status, presence: true
  validates :comment, presence: true

end

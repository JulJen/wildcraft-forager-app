class Task < ApplicationRecord
  belongs_to :project, optional: true
  belongs_to :user, optional: true

  include ActiveModel::Validations

  validates :comment, presence: true

  scope :by_most_recent_status, -> { order(updated_at: :desc) }

end

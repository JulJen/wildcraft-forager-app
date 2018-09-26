class Task < ApplicationRecord
  belongs_to :project, optional: true
  belongs_to :user, optional: true

  include ActiveModel::Validations

  validates :comment, presence: true

  scope :status, -> { where(status: true) }
  scope :formatted_updated_at, -> { order(formatted_updated_at: :desc) }
  scope :formatted_created_at, -> { order(formatted_created_at: :desc) }


  def formatted_updated_at
    updated_at.to_formatted_s(:long_ordinal)
  end

  def formatted_created_at
    created_at.to_formatted_s(:long_ordinal)
  end


end

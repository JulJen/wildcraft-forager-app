class Comment < ApplicationRecord #join table
  belongs_to :post
  belongs_to :user

  # include ActiveModel::Validations
  #
  #
  # validates :name, presence: true
  #
  # scope :active, -> { where(status: false) }
  # scope :inactive, -> { where(status: true) }


  # scope :formatted_updated_at, -> { order(formatted_updated_at: :desc) }
  # scope :formatted_created_at, -> { order(formatted_created_at: :desc) }
  #
  #
  # def formatted_updated_at
  #   updated_at.to_formatted_s(:long_ordinal)
  # end
  #
  # def formatted_created_at
  #   created_at.to_formatted_s(:long_ordinal)
  # end



end

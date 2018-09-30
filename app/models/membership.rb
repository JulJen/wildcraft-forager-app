class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :team

  # include ActiveModel::Validations

  # validates :name, presence: true


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

  # validates :user_id, presence: true

  def member_name
    User.find(self.user_id).name
  end

end

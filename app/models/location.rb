class Location < ApplicationRecord
  has_many :topics

  scope :alphabetical_order, -> {order(name: :asc)}
  #
  # include ActiveModel::Validations
  #
  # validates :name, presence: true

  # def self.find_location(topic_id)
  #   @member = Project.find_by_id(user_id).id
  #   return User.where(id: @member).select(:id, :name, :email, :time_zone, :language, :gender, :interest, :image).take
  # end

end

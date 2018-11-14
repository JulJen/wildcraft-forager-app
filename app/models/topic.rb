class Topic < ApplicationRecord
  belongs_to :category, optional: true

  has_many :memberships
  has_many :users, through: :memberships

  has_many :posts

  include ActiveModel::Validations

  validates :name, presence: true
  validates :name, uniqueness: true

  scope :by_recent_update, -> { order(updated_at: :desc) }
  scope :alphabetical_order, -> {order(name: :asc)}

  scope :inactive, -> { where(status: true) }
  scope :active, -> { where(status: false) }

  # validates :location_id, presence: true


  # scope :active, -> { where(status: true) }
  # scope :pending, -> { where(status: false) }
  # def self.is_authorized(user_id)
  #    @topic.memberships.where(user_id: current_user.id, admin: true)
  # end

  def self.find_location(location_id)
    @location = Location.find_by_id(@topic.location_id).id
    return Location.where(id: @location).select(:id, :name).take
  end


end

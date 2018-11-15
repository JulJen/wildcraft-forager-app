class Post < ApplicationRecord #formerly topics
  belongs_to :topic, optional: true
  
  has_many :users
  # has_many :comments
  # has_many :users, through: :comments

  include ActiveModel::Validations

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :description,  presence: true

  validates :status, :inclusion => {:in => [true, false]}

  scope :inactive, -> { where(status: true) }
  scope :active, -> { where(status: false) }

  scope :by_recent_update, -> { order(updated_at: :desc) }


  # def self.latest_topic
  #   order('updated_at desc').first
  # end
  #
  # def self.names
  #   pluck(:name)
  # end

  #Project.latest_topic


end

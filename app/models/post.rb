class Post < ApplicationRecord #formerly projects
  belongs_to :project, optional: true

  has_many :comments
  has_many :users, through: :comments

  include ActiveModel::Validations

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :description,  presence: true

  validates :status, :inclusion => {:in => [true, false]}

  scope :inactive, -> { where(status: true) }
  scope :active, -> { where(status: false) }



  # def self.latest_project
  #   order('updated_at desc').first
  # end
  #
  # def self.names
  #   pluck(:name)
  # end

  #Project.latest_project


end

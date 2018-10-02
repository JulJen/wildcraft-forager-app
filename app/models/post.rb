class Post < ApplicationRecord #formerly projects
  belongs_to :project

  has_many :comments
  has_many :users, through: :comments

  include ActiveModel::Validations

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :description,  presence: true


  def self.latest_project
    order('updated_at desc').first
  end

  def self.names
    pluck(:name)
  end

  #Project.latest_project


end

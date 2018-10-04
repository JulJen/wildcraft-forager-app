class Project < ApplicationRecord
  belongs_to :category, optional: true

  has_many :memberships
  has_many :users, through: :memberships

  has_many :posts

  include ActiveModel::Validations

  validates :name, presence: true
  validates :name, uniqueness: true

  # validates :category_id, presence: true


  # scope :active, -> { where(status: true) }
  # scope :pending, -> { where(status: false) }
  # def self.is_authorized(user_id)
  #    @project.memberships.where(user_id: current_user.id, admin: true)
  # end

  def self.find_category(category_id)
    @category = Category.find_by_id(@project.category_id).id
    return Category.where(id: @category).select(:id, :name).take
  end


end

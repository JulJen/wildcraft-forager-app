class Category < ApplicationRecord
  has_many :projects
  #
  # include ActiveModel::Validations
  #
  # validates :name, presence: true

  # def self.find_category(project_id)
  #   @member = Project.find_by_id(user_id).id
  #   return User.where(id: @member).select(:id, :name, :email, :time_zone, :language, :gender, :interest, :image).take
  # end

end

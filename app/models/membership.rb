class Membership < ApplicationRecord  #join table
  belongs_to :user, optional: true
  belongs_to :project, optional: true

  # include ActiveModel::Validations

  validates :admin, :inclusion => {:in => [true, false]}

  scope :project_admin, -> { where(admin: true) }
  scope :project_member, -> { where(admin: false) }


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



  def member_name
    User.find(self.user_id).name
  end

end

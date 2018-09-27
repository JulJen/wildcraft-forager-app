class Member < ApplicationRecord
  belongs_to :team

  include ActiveModel::Validations

  validates :user_id, presence: true

  def member_name
    User.find(self.user_id).name
  end

end

class Membership < ApplicationRecord  #join table
  belongs_to :user, optional: true
  belongs_to :topic, optional: true

  # include ActiveModel::Validations

  validates :admin, :inclusion => {:in => [true, false]}

  scope :topic_admin, -> { where(admin: true) }
  scope :topic_member, -> { where(admin: false) }



  # Membership.topic_admin.distinct.pluck(:user_id)


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

  # def self.grab_teammate(user_id)
  #   @member = User.find_by_id(user_id).id
  #   return User.where(id: @member).select(:id, :name, :email, :time_zone, :language, :gender, :interest, :image).take
  # end
  # @member = User.grab_teammate(params[:id])

  def count_admin
    @count_admin = Membership.where(user_id: current_user.id, admin: true).pluck(:user_id).count
    # @count_admin = @topic.memberships.where(user_id: current_user.id, admin: true).pluck(:user_id).count
  end

  def all_admin
    @all_admin = Membership.where(admin: true).distinct.pluck(:user_id)
    # @select_admin = @topic.memberships.where(user_id: current_user.id, admin: true).pluck(:user_id)
    # Membership.where(user_id: current_user.id, admin: true).distinct.pluck(:user_id)
  end

  def order_admin
    @select_admin = Membership.where(user_id: current_user.id, admin: true).pluck(:user_id)
    # @select_admin = @topic.memberships.where(user_id: current_user.id, admin: true).pluck(:user_id)
  end

  def current_admin
    @current_admin = Membership.where(user_id: current_user.id, admin: true).distinct.pluck(:user_id)
  end

  # Membership.topic_admin.where(user_id: current_user.id, admin: true)


  # @topic.memberships.map(&:user_id) == @current_admin
  # @topic.memberships.pluck(:user_id) == @current_admin

# User.all.collect(&:name)
# User.joins(:memberships).select('users.name')
  #
  # def member_name
  #   User.find(self.user_id).name
  # end


  # @zombie = Zombie.find 1
  # @statuses = @zombie.body_statuses.false.pluck(:body_id) #-> array of IDs with "false" status
  #
  # @user.tools.joins(:body_impacts).where('body_impacts.body_id IN (?)', @statuses)
  # ## or
  # @user.tools.joins(:body_impacts).find_by(id: @statuses)
end

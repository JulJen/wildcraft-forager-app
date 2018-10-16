class User < ApplicationRecord
  has_secure_password
  has_many :memberships
  has_many :projects, through: :memberships

  has_many :comments
  has_many :posts, through: :comments


  include ActiveModel::Validations

  validates :name, presence: true

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates_length_of :name, within: 2..30, too_long: 'pick a shorter name', too_short: 'pick a longer name'

  scope :inactive, -> { where(status: true) }
  
  scope :active, -> { where(status: false) }

  def self.grab_teammate(user_id)
    @member = User.find_by_id(user_id).id
    return User.where(id: @member).select(:id, :name, :email, :time_zone, :language, :gender, :interest, :image).take
  end

end
  # before_validation :remove_whitespaces


  # private
  #
  # def remove_whitespaces
  #   name.strip!
  # end





  # validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/


  # validates_presence_of :slug
  #
  # def to_param
  # slug
  # end

  # extend FriendlyId
  # friendly_id :username, use: :slugged
  # validates :username, presence: true
  # validates :username, :uniqueness => {:case_sensitive => false},
  # :format => { with: /\A[a-zA-Z0-9]+\Z/ }



  #
  # def slug=(value)
  #   if value.present?
  #     write_attribute(:slug, value)
  #   end
  # end
  #
  # def should_generate_new_friendly_id?
  #   new_record? || slug.nil? || slug.blank? # you can add more condition here
  # end

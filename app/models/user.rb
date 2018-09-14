class User < ApplicationRecord
  has_secure_password

  include ActiveModel::Validations
  has_many :teams
  # has_many :projects
  has_many :projects, through: :teams

  validates :name, :email, :password, presence: true

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates_length_of :name, maximum: 6

  validates_length_of :name, within: 2..20, too_long: 'pick a shorter name', too_short: 'pick a longer name'


  before_validation :remove_whitespaces

  private
    # def ensure_login_has_value
    #   if !signin_valid? ||
    #
    # end

  def remove_whitespaces
    name.strip!
  end





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

end

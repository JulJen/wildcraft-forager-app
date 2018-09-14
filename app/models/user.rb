class User < ApplicationRecord
  has_secure_password

  has_many :teams
  # has_many :projects
  has_many :projects, through: :teams

  validates :name, :email, presence: true
  validates :email,  uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
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

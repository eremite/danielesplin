class User < ActiveRecord::Base

  attr_accessible :name, :email

  has_secure_password

  has_many :log_entries

  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: Rails.application.config.email_regex }
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 4 }, allow_blank: true

end

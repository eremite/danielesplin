class User < ActiveRecord::Base

  attr_accessible :name, :email

  has_secure_password

  has_many :entries
  has_many :log_entries
  has_many :photos

  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: Rails.application.config.email_regex }
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 4 }, allow_blank: true

  def log(action)
    log_entries.create(action: action)
  end

end

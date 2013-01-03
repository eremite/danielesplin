class User < ActiveRecord::Base

  attr_accessible :name, :email, :password, :password_confirmation

  has_secure_password

  has_many :entries
  has_many :log_entries
  has_many :photos
  has_many :thoughts
  has_many :comments

  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: Rails.application.config.email_regex }
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 4 }, allow_blank: true

  def log(action)
    log_entries.create(action: action)
  end

  def daniel?
    email == 'daniel@danielesplin.org'
  end

  def erika?
    email == 'erika@danielesplin.org'
  end

end

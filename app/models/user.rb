class User < ActiveRecord::Base

  ROLES = %w(father mother baby guest)

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
  validates :api_key, uniqueness: true, allow_blank: true

  scope :guest, -> { where(role: :guest) }


  def log(action)
    log_entries.create(action: action)
  end

  def father?
    role == 'father'
  end

  def mother?
    role == 'mother'
  end

  def parent?
    father? || mother?
  end

  def baby?
    role == 'baby'
  end

  def guest?
    role == 'guest'
  end

  def users_whose_entries_i_can_edit
    return [] if guest?
    users = [self]
    users += User.where(:role => 'baby') if parent?
    users
  end

end

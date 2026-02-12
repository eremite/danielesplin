class User < ApplicationRecord

  enum :role, { father: "father", mother: "mother", child: "child", guest: "guest", inactive: "inactive" }

  EMAIL_REGEX = /\A(?:[a-z\d!#\$%&'\*\+\-\/=\?\^_`\{\|\}~]+|\.)+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\Z/i
  ACCESS_TOKEN_EXPIRES_IN = 1.week

  has_secure_password validations: false

  has_many :comments
  has_many :entries
  has_many :log_entries
  has_many :notes
  has_many :photos

  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: EMAIL_REGEX }
  validates :password, length: { minimum: 4, maximum: 72 }, allow_blank: true
  validates :api_key, uniqueness: true, allow_blank: true

  scope :guest, -> { where(role: :guest) }

  def parent?
    father? || mother?
  end

  def users_whose_entries_i_can_edit
    return User.where(role: %w[father mother child]).order(born_at: :asc) if parent?
    return User.where(id: id) if child?
    []
  end

  def random_entry_on_the_same_day_of_the_year
    return unless born_at?
    year_span = Time.current.year - born_at.year
    25.times do
      same_day_different_year = (rand(year_span) + 1).years.ago.all_day
      entry = entries.find_by(at: same_day_different_year)
      return entry if entry.present?
    end
    nil
  end

  def log(action)
    touch(:viewed_blog_at) if action.to_s == 'blog'
    log_entries.create(action: action)
  end

  def entry_for_today
    entries.find_by(at: Time.current.all_day)
  end

  def login_redirect
    return :entries if parent? && entry_for_today.blank?
    :posts
  end

  def grant_access
    self.access_token = SecureRandom.urlsafe_base64(16)
    self.access_token_expires_at = ACCESS_TOKEN_EXPIRES_IN.from_now
  end

  def grant_access!
    grant_access
    save!
  end

end

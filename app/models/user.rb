class User < ApplicationRecord

  ROLES = %w(father mother baby grandparent guest)

  has_secure_password

  has_many :comments
  has_many :entries
  has_many :log_entries
  has_many :notes
  has_many :photos

  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: Rails.application.config.email_regex }
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 4 }, allow_blank: true
  validates :api_key, uniqueness: true, allow_blank: true

  scope :guest, -> { where(role: :guest) }
  scope :viewed_blog_at_desc, -> { where.not(viewed_blog_at: nil).order(arel_table[:viewed_blog_at].desc) }


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

  def grandparent?
    role == 'grandparent'
  end

  def users_whose_entries_i_can_edit
    return [] unless parent?
    User.where(role: %w[father mother baby])
  end

  def log(action)
    log_entries.create(action: action)
  end

  def entry_for_today
    entries.find_by(at: Time.current.all_day)
  end

  def login_redirect
    return :entries if parent? && entry_for_today.blank?
    :visible_posts
  end

end

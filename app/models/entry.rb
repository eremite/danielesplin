class Entry < ActiveRecord::Base

  attr_accessor :baby_body

  attr_accessible :at, :body, :public, :baby_body

  belongs_to :user
  has_many :comments
  has_many :entry_photos
  has_many :photos, through: :entry_photos

  after_save :create_baby_entry, if: lambda { |e| e.baby_body.present? }

  validates :body, presence: true

  scope :at_desc, order(arel_table[:at].desc)
  scope :public, where(public: true)
  scope :private, where(public: false)
  scope :published, lambda { |*b| where(!!b.first ? arel_table[:at].lt(Time.zone.now) : arel_table[:at].gt(Time.zone.now) ) }


  def title
    body.split(/\r?\n/).first.gsub(/[^\w\s\.\?,!]/, '').squish.first(50)
  end

  def dated_title
    "#{I18n.l(at.to_date)} #{title}"
  end

  def existing_baby_body
    baby = User.where(role: 'baby').first
    return nil if baby.nil? || at.nil?
    baby.entries.where(:at => at.beginning_of_day..at.end_of_day).first.try(:body)
  end


  private

  def create_baby_entry
    baby = User.where(role: 'baby').first
    if baby
      baby.entries.where(:at => at).destroy_all
      baby.entries.create({
        at: at,
        body: baby_body,
      })
    end
  end

end

class Entry < ActiveRecord::Base

  attr_accessor :baby_body

  attr_accessible :at, :body, :public, :baby_body

  belongs_to :user
  has_many :comments

  after_create :create_baby_entry, if: lambda { |e| e.baby_body.present? }

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

  def photos
    t = Photo.arel_table
    conditions = t[:at].in(at.beginning_of_day..at.end_of_day).and(t[:entry_id].eq(nil))
    conditions = conditions.or(t[:entry_id].eq(id))
    Photo.where(conditions)
  end

  def baby_body
    return @baby_body if defined?(@baby_body)
    baby = User.where(email: 'baby@danielesplin.org').first
    return nil if baby.nil?
    time = Time.zone.now
    @baby_body = baby.entries.where(:at => time.beginning_of_day..time.end_of_day).first
  end


  private

  def create_baby_entry
    baby = User.where(email: 'baby@danielesplin.org').first
    baby.entries.create({
      at: at,
      body: baby_body,
    }) if baby
  end

end

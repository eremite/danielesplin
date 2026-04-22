class PhotoSearch
  include ActiveModel::Model

  attr_accessor :media, :order, :ends_on, :nondescript, :term, :tag, :page, :photos, :unblogged, :not_hidden

  def self.order_options
    [['Photo Date', :at_desc], ['Date Uploaded', :created_at_desc], ['Last Modified', :updated_at_desc]]
  end

  def load
    self.ends_on = parse_date(ends_on)
    self.photos = find_photos
    self
  end

  private

  def find_photos
    results = set_order(Photo.all)
    results = media_filter(results) if media.present?
    results = results.where(at: Time.zone.at(0)..ends_on) if ends_on.present?
    results = results.tagged_with(tag, on: :photo_tags) if tag.present?
    results = term_filter(results) if term.present?
    results = results.where(description: [nil, '']) if nondescript.to_i.nonzero?
    results = results.includes(:post_photos).where(post_photos: { photo_id: nil }) if unblogged.to_i.nonzero?
    results = results.where(hidden: false) unless not_hidden.to_i.nonzero?
    results.page(page).per(30)
  end

  def set_order(results)
    case order
    when 'created_at_desc'
      results.created_at_desc
    when 'updated_at_desc'
      results.order(updated_at: :desc)
    else
      results.at_desc
    end
  end

  def media_filter(results)
    results.joins(image_attachment: :blob).where(active_storage_blobs: { content_type: content_type })
  end

  def content_type
    media == 'videos' ? 'video/mp4' : 'image/jpeg'
  end

  def term_filter(results)
    results.where(Photo.arel_table[:description].matches("%#{term.to_s.downcase}%"))
  end

  def parse_date(date_string)
    Date.parse(date_string)
  rescue ArgumentError, TypeError
    Date.current
  end
end

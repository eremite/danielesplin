class PhotoFrame

  DAY_SPAN = 7

  def next_photo
    photo_ids = Rails.cache.read(cache_key).to_a.presence || get_photos.pluck(:id).shuffle
    next_id = photo_ids.shift
    Rails.cache.write(cache_key, photo_ids, expires_in: 24.hours)
    Photo.find_by(id: next_id)
  end

  private

  def cache_key
    'photo_ids_for_photo_frame'
  end

  def get_photos
    day_of_year = Time.current.strftime("%j").to_i
    range = start_day_of_year = (day_of_year - DAY_SPAN)..(day_of_year + DAY_SPAN)
    if range.first < 1 || range.last > 366
      low_bound = (range.first - 1) % 366 + 1
      high_bound = (range.last - 1) % 366 + 1
      photos.where(julian_func.gteq(low_bound).or(day_of_year.lteq(high_bound)))
    else
      photos.where(julian_func.between(range))
    end
  end

  def julian_func
    Arel::Nodes::NamedFunction.new(
      "CAST", [
        Arel::Nodes::NamedFunction.new("strftime", [Arel::Nodes.build_quoted("%j"), Photo.arel_table[:at]])
        .as("INTEGER")
      ]
    )
  end

  def photos
    Photo.where(hidden: false)
  end

end

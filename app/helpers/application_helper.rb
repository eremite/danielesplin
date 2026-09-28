module ApplicationHelper

  include ActsAsTaggableOn::TagsHelper

  FUN_ICONS = %w[
    airplane award backpack2 bag-heart ballon-heart ballon bluesky binoculars bookmark-heart box2-heart bricks
    brilliance cake cake2 calculator camera chat-square-heart check-circle check-square check2-circle check2-square
    cloud-moon cloud-sun cookie droplet egg-fried emoji-grin emoji-heart-eyes emoji-laughing emoji-smile
    emoji-sunglasses envelope-heart envelope-paper-heart gift hand-thumbs-up heart hearts house-heart hypnotize leaf
    lightbulb lightning moon moon-stars mortarboard music-note-list rocket rocket-takeoff scooter send sun
  ].freeze

  def l(object, locale: nil, format: nil, **options)
    super if object
  end

  def timespan(from_time, to_time)
    parts = ActiveSupport::Duration.build((to_time - from_time).to_i.abs).parts
    parts.slice(:years, :months, :weeks, :days).map do |key, value|
      "#{value} #{key.to_s.singularize.pluralize(value)}"
    end.join(', ')
  end

  def random_icon(options = {})
    classes = Array(options[:class]).unshift("bi-#{FUN_ICONS.sample}").join(' ')
    tag.i(class: classes, **options.except(:class))
  end

end

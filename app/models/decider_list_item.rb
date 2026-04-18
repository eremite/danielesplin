class DeciderListItem < ApplicationRecord
  belongs_to :decider_list

  validates :name, presence: true

  ICON_LIST = %w[
    alarm
    award
    bag-check
    bank
    basket
    bell
    bicycle
    box
    briefcase
    brush
    bug
    camera
    cloud-drizzle
    cloud-lightning-rain
    cloud-sun
    droplet-half
    egg
    emoji-heart-eyes
    emoji-laughing
    emoji-smile
    emoji-sunglasses
    emoji-wink
    flag
    flower1
    flower2
    flower3
    heart
    house-door
    key
    life-preserver
    lightning
    mask
    moon-stars
    music-note
    music-note-beamed
    palette
    pen
    pencil
    piggy-bank
    snow
    snow2
    snow3
    sun
  ].freeze

  FONT_LIST = ['Georgia', 'Garamond', 'Comic Sans MS'].freeze

  def icon
    ICON_LIST.sample
  end

  def font
    FONT_LIST.last
  end
end

class DeciderListItem < ApplicationRecord

  belongs_to :decider_list

  validates :name, presence: true

  def icon
    icon_list.sample
  end

  def font
    font_list.last
  end

  private

  def icon_list
    %w[
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
    ]
  end

  def font_list
    %w[
      Georgia
      Garamond
      Comic\ Sans\ MS
    ]
  end

end

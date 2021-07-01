class DeciderListItem < ApplicationRecord

  belongs_to :decider_list

  def icon
    icon_list.sample
  end

  def font
    font_list.last
  end

  private

  def icon_list
    %w[
      bell-o
      anchor
      smile-o
      bed
      bicycle
      birthday-cake
      bolt
      book
      bus
      car
      check-square-o
      child
      cut
      cutlery
      diamond
      eye
      fighter-jet
      fire
      flag
      flask
      gift
      graduation-cap
      heart-o
      home
      key
      leaf
      lightbulb-o
      linux
      medkit
      moon-o
      music
      paper-plane
      paperclip
      pencil
      plane
      recycle
      rocket
      scissors
      ship
      space-shuttle
      spinner
      star
      star-o
      tree
      truck
      twitter
      umbrella
      wrench
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

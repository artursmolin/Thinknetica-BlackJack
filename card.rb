class Card
  SUITS = %w[♦ ♣ ♠ ♥].freeze
  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  attr_reader :rank, :suit, :points

  def initialize(options)
    self.rank = options[:rank]
    self.suit = options[:suit]
    self.points = options[:points]
    raise 'Wrong format' unless valid?
  end

  private

  def to_s
    "#{rank} #{suit}"
  end

  def to_str
    "#{rank} #{suit}"
  end

  def valid?
    SUITS.include?(suit) && RANKS.include?(rank)
  end

  def card_points(card)
    if %w[2 3 4 5 6 7 8 9 10].include?(card)
      card.to_i
    elsif %w[J Q K].include?(card)
      10
    else
      'T'
    end
  end

  attr_writer :rank, :suit, :points
end

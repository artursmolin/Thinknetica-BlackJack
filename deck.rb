class Deck
  attr_reader :cards

  def initialize
    self.cards = []

    generate_new
  end

  def give_cards(count)
    selected_cards = []
    count.times do
      card_index = rand(cards.length)
      card = cards.delete_at(card_index)
      selected_cards << card
    end
    selected_cards
  end

  private

  attr_writer :cards

  def generate_new
    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank|
        cards << Card.new(suit: suit, rank: rank, points: card_points(rank))
      end
    end
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
end

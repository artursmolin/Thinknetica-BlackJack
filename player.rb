class Player
  BANK = 100
  attr_reader :name, :hand
  attr_writer :ready_to_open
  attr_accessor :bank

  def initialize
    self.bank = BANK
    self.hand = Hand.new
  end

  def get_name
    loop do
      player_name = gets.strip.chomp.capitalize
      self.name = player_name
      break unless player_name.length.zero?
    end
    system('clear')
  end

  def take(cards)
    hand.cards.concat(cards)
  end

  def move(game)
    action = gets.strip.chomp.to_i
    if action == 2
      take game.deck.give_cards(1)
    elsif action == 3
      self.ready_to_open = true
    end
  end

  def ready_to_open?
    ready_to_open
  end

  def reset_cards
    self.hand = Hand.new
  end


  def cards_opened
    self.hand.cards.join(', ')
  end

  def cards_sum
    self.hand.sum
  end

  private

  attr_writer :name, :hand
  attr_reader :ready_to_open
end

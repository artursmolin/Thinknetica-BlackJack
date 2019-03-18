class Game
  attr_reader :menu, :player, :deck, :dealer, :message_panel, :bank

  def initialize(options)
    self.menu = options[:menu]
    self.player = options[:player]
    self.dealer = options[:dealer]
    self.message_panel = options[:message_panel]
    self.bank = 0
  end

  def start
    p 'Please introduce yourself.'
    player.get_name
    loop do
      main_game
      finalize
      system("clear")
      stop
      p "D you want to play a new game? Put yes or no"
      input = gets.chomp
      if input == "yes"
        reset_game
      elsif input == "no"
        raise "Exiting the program"
      end
      break if
        player.bank.zero? || dealer.bank.zero?
    end
  end

  def main_game
    renew_deck
    game_starting
    send_starting_cards
    bet
    loop do
      move
      break if
          check_for_three_cards || player.ready_to_open?
    end
  end

  private

  def stop
    p "**********************************************"
    p "Game results: "
    p "Dealer: #{dealer.hand.cards.join(', ')}, points: #{player.hand.sum}, bank: #{dealer.bank}"
    p "Player: #{player.hand.cards.join(', ')}, points: #{dealer.hand.sum}, bank: #{player.bank}"
    p "***********************************************"
  end

  def renew_deck
    self.deck = Deck.new
  end

  def send_starting_cards
    player.take(deck.give_cards(2))
    dealer.take(deck.give_cards(2))
  end

  def bet
    player.bank -= 10
    dealer.bank -= 10
    self.bank += 20
  end

  def move
    dashboard(player, dealer, self)
    move_menu
    player.move self
    dashboard(player, dealer, self)
    message_from_dealer = dealer.move self
    p "Dealer is #{message_from_dealer}"
    dashboard(player, dealer, self)
  end

  def check_for_three_cards
    player.hand.cards.count > 4 && dealer.hand.cards.count > 4
  end

  def find_winner
    player_score = player.hand.sum
    dealer_score = dealer.hand.sum
    if player_score <= 21 && dealer_score > 21 || dealer_score < player_score
      winner = player
      player.bank += 20
    elsif dealer_score <= 21 && player_score > 21 || player_score < dealer_score
      winner = dealer
      dealer.bank += 20
    end
  end

  def reset_game
    self.bank = 0
    player.reset_cards
    dealer.reset_cards
  end

  def finalize
    find_winner
    player.ready_to_open = false
    p 'Game finished' if player.bank.zero? || dealer.bank.zero?
  end

  def game_starting
    p 'Game starting'
  end

  def dashboard(player, dealer, game)
    dealer_cards = dealer.hand.cards.count.times.map { '*' }
    p "| Casino bank: #{game.bank}"
    p "| Player cards: #{player.hand.cards.join(', ')} | bank: #{player.bank}"
    p "| Dealer cards: #{dealer_cards.join(' ')} | bank: #{dealer.bank}"
  end

  def move_menu
    p '| Your turn:'
    p '| 1. Pass'
    p '| 2. Take card'
    p '| 3. Open cards'
  end

  def ready_to_open_cards; end

  attr_writer :menu, :player, :deck, :dealer, :message_panel, :bank
end

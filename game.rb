class Game
  attr_reader :menu, :player, :dealer, :deck, :message_panel, :bank

  def initialize(options)
    self.menu = options[:menu]
    self.player = options[:player]
    self.dealer = options[:dealer]
    self.message_panel = options[:message_panel]
    self.bank = 0
  end

  def start
    message_panel.player_name
    player.get_name
    loop do
      main_game
      finalize
      message_panel.stop(player, dealer)
      message_panel.new_game
      reset_game
      break if
        player.bank.zero? || dealer.bank.zero?
    end
  end

  def main_game
    renew_deck
    send_starting_cards
    bet
    loop do
      move
      break if
          check_for_three_cards || player.ready_to_open? || check_for_blackjack_over
      end
  end

  private

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
    message_panel.dashboard_first(player, dealer, self)
    message_panel.move_menu
    player.move self
    message = dealer.move self
    message_panel.dealer_message(message)
  end

  def check_for_three_cards
    player.hand.cards.count > 4 && dealer.hand.cards.count > 4
  end

  def check_for_blackjack_over
    player.hand.sum > 21 || dealer.hand.sum > 21
  end

  def find_winner
    player_score = player.hand.sum
    dealer_score = dealer.hand.sum
    if player_score > 21 || dealer_score > player_score && dealer_score <= 21
      dealer.bank += 20
      message_panel.dealer_winner
    elsif dealer_score > 21 || dealer_score < player_score && player_score <= 21
      player.bank += 20
      message_panel.player_winner(player)
    elsif dealer_score == player_score
      player.bank +=10
      dealer.bank +=10
      message_panel.draw_winner
    end
  end

  def finalize
    find_winner
    player.ready_to_open = false
    message_panel.game_end if player.bank.zero? || dealer.bank.zero?
  end

  def ready_to_open_cards; end

  def reset_game
    self.bank = 0
    player.reset_cards
    dealer.reset_cards
  end

  attr_writer :menu, :player, :deck, :dealer, :message_panel, :bank
end

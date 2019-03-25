class MessagePanel
  def new_game
    p 'D you want to play a new game? Put yes, if you want to continue'
    input = gets.chomp
    if input != "yes"
      p 'Thanks for game!'
      exit
    end
    system('clear')
  end

  def player_name
    p 'Please introduce yourself.'
  end

  def stop(player, dealer)
    p '**********************************************'
    p 'Game results: '
    p "Dealer: #{dealer.cards_opened}, points: #{dealer.cards_sum}, bank: #{dealer.bank}"
    p "Player: #{player.cards_opened}, points: #{player.cards_sum}, bank: #{player.bank}"
    p '***********************************************'
  end

  def dashboard_first(player, dealer, game)
    dealer_cards = dealer.cards_closed
    p "Casino bank: #{game.bank}"
    p "-------------------------"
    p "Player cards: #{player.cards_opened} | bank: #{player.bank}"
    p "Dealer cards: #{dealer_cards.join(' ')} | bank: #{dealer.bank}"
    p "-------------------------"
  end

  def move_menu
    p 'Your turn:'
    p '1. Pass'
    p '2. Take card'
    p '3. Open cards'
  end

  def dealer_message(message)
    p "Dealer is #{message}"
  end

  def dealer_winner
    p 'Dealer win!'
    system('clear')
  end

  def player_winner(player)
    p "#{player.name} win!"
    system('clear')
  end

  def draw_winner
    p 'Draw!'
  end

  def game_end
    p 'Game finished'
  end
end

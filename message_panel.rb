class MessagePanel
  def new_game
    p 'D you want to play a new game? Put yes, if you want to continue'
    input = gets.chomp
    if input != "yes"
      p 'Thanks for game!'
      exit
    end
  end

  def player_name
    p 'Please introduce yourself.'
  end

  def stop(player, dealer)
    p '**********************************************'
    p 'Game results: '
    p "Dealer: #{dealer.hand.cards.join(', ')}, points: #{dealer.hand.sum}, bank: #{dealer.bank}"
    p "Player: #{player.hand.cards.join(', ')}, points: #{player.hand.sum}, bank: #{player.bank}"
    p '***********************************************'
  end

  def dashboard_first(player, dealer, game)
    dealer_cards = dealer.hand.cards.count.times.map { '*' }
    p "Casino bank: #{game.bank}"
    p "-------------------------"
    p "Player cards: #{player.hand.cards.join(', ')} | bank: #{player.bank}"
    p "Dealer cards: #{dealer_cards.join(' ')} | bank: #{dealer.bank}"
    p "-------------------------"
  end

  def move_menu
    p 'Your turn:'
    p '1. Pass'
    p '2. Take card'
    p '3. Open cards'
  end
end

class Dealer < Player
  def name
    'Dealer'
  end

  def move(game)
    cards_sum = hand.sum
    if cards_sum >= 17
      'skip'
    else
      take game.deck.give_cards(1)
      'took'
    end
  end
  
  def cards_closed
    self.hand.cards.count.times.map { '*' }
  end
end

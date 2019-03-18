require_relative 'game.rb'
require_relative 'player.rb'
require_relative 'dealer.rb'
require_relative 'deck.rb'
require_relative 'card.rb'
require_relative 'hand.rb'

player = Player.new
dealer = Dealer.new

game_params = {
  player: player,
  dealer: dealer
}

game = Game.new(game_params)

game.start

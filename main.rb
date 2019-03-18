require_relative 'game.rb'
require_relative 'player.rb'
require_relative 'dealer.rb'
require_relative 'deck.rb'
require_relative 'card.rb'
require_relative 'hand.rb'
require_relative 'message_panel.rb'

player = Player.new
dealer = Dealer.new
message_panel = MessagePanel.new

game_params = {
  player: player,
  dealer: dealer,
  message_panel: message_panel
}

game = Game.new(game_params)

game.start

require 'bundler'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/game'
#require_relative 'lib/XXX'

player1 = Player.new("Lulu la crapule")
player2 = Player.new("Godzila")

binding.pry
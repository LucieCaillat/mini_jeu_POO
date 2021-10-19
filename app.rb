require 'bundler'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/game'
#require_relative 'lib/XXX'

player1 = Player.new("Lulu la terreur")
player2 = Player.new("Carlos le crado")
puts " A ma droite nous avons #{player1.name}\n Et à ma gauche nous avons #{player2.name}"
puts "\nvoici l'état de nos deux joueurs : "
player1.show_state
player2.show_state
gets.chomp
puts "\n\#####le combat va commencer !!!! #####"
while player1.life_points != 0 && player2.life_points != 0
    player1.attacks(player2)
    puts "\nvoici l'état de nos deux joueurs :"
    player1.show_state
    player2.show_state
    gets.chomp
    break if player2.life_points == 0
    player2.attacks(player1)
    puts "\nvoici l'état de nos deux joueurs :"
    player1.show_state
    player2.show_state
    gets.chomp
end

puts "\n###fin du combat!###"


#binding.pry
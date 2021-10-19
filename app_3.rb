require 'bundler'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/game'
#require_relative 'lib/XXX'


my_game = Game.new("Wolverine")


puts "------------------------------------------------"
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-------------------------------------------------"
puts "\n Entre ton noms :"
print "=> "
humain_name = gets.chomp
my_game = Game.new(humain_name)
my_game.show_players
puts "\n####Le combat commence !###"
while my_game.is_still_ongoing?
    my_game.menu
    prints "=> "
    choice = gets.chomp
    my_game.menu_choice(choice)
    my_game.enemies_attack
end
my_game.end

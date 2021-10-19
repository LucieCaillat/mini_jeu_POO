require 'bundler'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/game'
#require_relative 'lib/XXX'





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
gets.chomp
while my_game.is_still_ongoing == true
    my_game.menu
    print "=> "
    choice = gets.chomp
    my_game.menu_choice(choice)
    my_game.enemies_attack
    my_game.new_players_in_sight
    gets.chomp
end
my_game.end

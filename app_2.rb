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
player1_name = gets.chomp
player1 = HumanPlayer.new(player1_name)
enemy1 = Player.new("Godzila")
enemy2 = Player.new("Kraken")
player1.show_state
puts "\n####Le combat commence !###"
while player1.life_points > 0 && (enemy1.life_points > 0 || enemy2.life_points > 0)
    puts "\nQuelle action veux-tu effectuer ?"
    puts "\n a - chercher une meilleure arme"
    puts " s - chercher à se soigner"
    puts "\n     attaquer un joueur en vue :"
    print "\n 0 - "
    enemy1.show_state
    print " 1 - "
    enemy2.show_state
    print "\n=>"
    choice = gets.chomp
    if choice == "a"
        player1.search_weapon
        player1.show_state
    elsif choice == "s"
        player1.search_health_pack
        player1.show_state
    elsif choice == "0"
        player1.attacks(enemy1)
        enemy1.show_state
    elsif choice == "1"
        player1.attacks(enemy2)
        enemy2.show_state
    else
        puts "Je n'ai pas compris votre choix. \nVous passez votre tour"
    end
    gets.chomp
    Player.all.each do |enemy| 
        if enemy.life_points > 0
            enemy.attacks(player1)
            gets.chomp
        end
    end
    player1.show_state
    gets.chomp
end

if player1.life_points > 0
    puts "BRAVO ! TU AS GAGNE !" 
else
    puts "Loser ! Tu as perdu !"
end


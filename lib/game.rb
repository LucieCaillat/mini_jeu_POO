require 'bundler'
Bundler.require
require 'pry'
require 'dotenv'

Dotenv.load('.env')


class Game
    attr_accessor :human_player
    attr_accessor :enemies
  

    def initialize(human_name_to_save)
        enemy1 = Player.new("Godzila")
        enemy2 = Player.new("Kraken")
        enemy3 = Player.new("Yéti")
        enemy4 = Player.new("Dracula")
        @enemies = [enemy1 , enemy2 , enemy3 , enemy4]
        @humaine_player = HumanPlayer.new(human_name_to_save)
    end

    def kill_player(enemy_to_kill)
        @enemies.delete(enemy_to_kill)
    end 

    def is_still_ongoing
        if @enemies == [] || @humaine_player.life_points <= 0
            return false
        else
            return true
        end
    end

    def show_players
        @humaine_player.show_state
        @enemies.each{|enemy| enemy.show_state}
    end

    def menu
        puts "\nQuelle action veux-tu effectuer ?"
        puts "\n a - chercher une meilleure arme"
        puts " s - chercher à se soigner"
        puts "\n     attaquer un joueur en vue :"
        for num in (1..@enemies.length)
            print"\n #{num} - "
            @enemies[num - 1].show_state
        end
    end

    def menu_choice(choice)
        if choice == "a"
            @humaine_player.search_weapon
            @humaine_player.show_state
            gets.chomp
        elsif choice == "s"
            @humaine_player.search_health_pack
            @humaine_player.show_state
            gets.chomp
        elsif choice.to_i < @enemies.length && choice.to_i > 0 
            
            @humaine_player.attacks(@enemies[choice.to_i - 1])
            @enemies[choice.to_i - 1].show_state 
            gets.chomp 
            kill_player(@enemies[choice.to_i - 1]) if @enemies[choice.to_i - 1].life_points <= 0
                   
        else
            puts "Je n'ai pas compris votre choix. \nVous passez votre tour"
            gets.chomp
        end
    end

    def enemies_attack
        @enemies.each do |enemy|
            enemy.attacks(@humaine_player)
            @humaine_player.show_state
            gets.chomp
        end
    end

    def end
        if @humaine_player.life_points > 0
            puts "BRAVO ! TU AS GAGNE !" 
        else
            puts "Loser ! Tu as perdu !"
        end
    end


end

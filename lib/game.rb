require 'bundler'
Bundler.require
require 'pry'
require 'dotenv'

Dotenv.load('.env')


class Game
    attr_accessor :human_player
    attr_accessor :enemies
    attr_accessor :player_left
    
  

    def initialize(human_name_to_save)
        enemy1 = Player.new("Godzila")
        enemy2 = Player.new("Kraken")
        enemy3 = Player.new("Yéti")
        enemy4 = Player.new("Dracula")
        @enemies = [enemy1 , enemy2 , enemy3 , enemy4]
        @humaine_player = HumanPlayer.new(human_name_to_save)
        @player_left =10
    end

    def kill_player(enemy_to_kill) #Methode pour enlever un ennemi de l'array @enemies
        @enemies.delete(enemy_to_kill)
    end 

    def is_still_ongoing #Methode pour savoir si le jeu doit continuer
        if (@enemies == [] && @player_left == 0)|| @humaine_player.life_points <= 0
            return false
        else
            return true
        end
    end

    def show_players # Methode pour afficher les states des personnages"
        @humaine_player.show_state
        @enemies.each{|enemy| enemy.show_state}
    end

    def menu # Methode pour afficher le menu
        puts "\nQuelle action veux-tu effectuer ?"
        puts "\n a - chercher une meilleure arme"
        puts " s - chercher à se soigner"
        puts "\n     attaquer un joueur en vue :"
        for num in (1..@enemies.length)
            print"\n #{num} - "
            @enemies[num - 1].show_state
        end
    end

    def menu_choice(choice) # Methode pour appliquer les choix du menu"
        if choice == "a"
            @humaine_player.search_weapon
            @humaine_player.show_state
            gets.chomp
        elsif choice == "s"
            @humaine_player.search_health_pack
            @humaine_player.show_state
            gets.chomp
        elsif choice.to_i <= @enemies.length && choice.to_i > 0 
            
            @humaine_player.attacks(@enemies[choice.to_i - 1])
            @enemies[choice.to_i - 1].show_state 
            gets.chomp 
            kill_player(@enemies[choice.to_i - 1]) if @enemies[choice.to_i - 1].life_points <= 0
                   
        else
            puts "Je n'ai pas compris votre choix. \nVous passez votre tour"
            gets.chomp
        end
    end

    def enemies_attack #Methode pour que tous les ennemis attaquent"
        @enemies.each do |enemy|
            enemy.attacks(@humaine_player)
            @humaine_player.show_state
            gets.chomp
        end
    end
    
    def new_players_in_sight #Methode pour rajouter des ennemis en vu
        if @player_left <= 0
            puts"Tous les joueurs sont en vue"
        else
             dice_roll = rand(1..6)
             if dice_roll == 1
                puts "aucun nouveau joueur adverse n'arrive"
            elsif dice_roll >= 2 && dice_roll <= 4        
                @enemies<< Player.new("Monstre #{player_left}")
                @player_left = @player_left - 1
                puts "Attention un nouvel ennemi arrive !"
            else
                @enemies<< Player.new("Monstre #{player_left}")
                @player_left = @player_left - 1
                if @player_left > 0
                    @enemies<< Player.new("Monstre #{player_left}")
                    @player_left = @player_left - 1
                    puts "Attention deux nouveaux ennemis arrivent ! "
                end
            end
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

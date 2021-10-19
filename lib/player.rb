require 'bundler'
Bundler.require
require 'pry'
require 'dotenv'
Dotenv.load('.env')


class Player
    attr_accessor :name
    attr_accessor :life_points
    @@enemies = []

    def initialize( name_to_save )
        @name = name_to_save
        @life_points = 10
        @@enemies<< self
    end

    def self.all
        return @@enemies
    end

    def show_state
        puts "#{@name} a #{@life_points} points de vie"
    end

    def gets_damage(number_of_damage)
        @life_points = @life_points - number_of_damage
        if @life_points <= 0
            @life_points = 0
            puts "Le joueur #{@name} a été tué !"
        end
    end

    def attacks(other_player)
        puts "\n #{@name} attaque #{other_player.name} ! "
        damage = compute_damage.to_i
        puts " Il vient d'infliger #{damage} points de dommages."
        other_player.gets_damage(damage) 
    end

    private

    def compute_damage
        return rand(1..6)
    end


end

class HumanPlayer < Player
    attr_accessor :weapon_level

    def initialize(name_to_save)
        @name = name_to_save
        @weapon_level = 1
        @life_points = 100
        
    end

    def show_state
        puts "\n tu as #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
    end

    def search_weapon
        power_new_weapon = rand(1..6)
        puts "Tu as trouvé une arme de niveau #{power_new_weapon}"
        if power_new_weapon > @weapon_level
            puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
            @weapon_level = power_new_weapon
        else
            puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
        end
    end

    def search_health_pack
        power_health_pack = rand(1..6)
        if power_health_pack > 1 && power_health_pack < 6
            puts "Bravo, tu as trouvé un pack de +50 points de vie !"
            @life_points += 50
            @life_points = 100 if @life_points > 100
        elsif power_health_pack == 6
            puts "Waow, tu as trouvé un pack de +80 points de vie !"
            @life_points += 80
            @life_points = 100 if @life_points > 100
        else
            puts "Tu n'as rien trouvé... "
        end
    end


    private

    def compute_damage
        return rand(1..6) * @weapon_level
    end
end
require 'bundler'
Bundler.require
require 'pry'
require 'dotenv'
Dotenv.load('.env')


class Player
    attr_accessor :name
    attr_accessor :life_points

    def initialize( name_to_save , initialize_life_points = 10)
        @name = name_to_save
        @life_points = initialize_life_points
    end

    def show_state
        puts "Joueur #{self.name} : #{self.life_points} points de vie"
    end

    def gets_damage(number_of_damage)
        @life_points = @life_points - number_of_damage
        if @life_points <= 0
            @life_points = 0
            puts "Le joueur #{self.name} a été tué !"
        end
    end



end
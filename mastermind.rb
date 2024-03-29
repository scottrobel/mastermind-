require './mastermind_toolbox.rb'
require './modes.rb'
class MasterMind
    def initialize(digits=5, range=6)
        new_game(digits,range)
    end
    private
    def another_game?(digits,range)
        MasterMindToolBox::print_like_its_typed("Would You like to play another game?")
        MasterMindToolBox::print_like_its_typed("Y=Yes  anykey=No")
        input = gets.chomp
        new_game(digits, range) if(input.downcase == "y")

    end 
    def new_game(digits,range)
        MasterMindToolBox::print_like_its_typed("Would you like to be code Breaker or Code Maker?")
        MasterMindToolBox::print_like_its_typed("CB = Code Breaker")
        MasterMindToolBox::print_like_its_typed("CM = Code Maker")
        game_mode = gets.chomp.downcase
        if(game_mode == "cb")
            Modes::CodeBreakerMode.new(digits,range)
        elsif(game_mode == "cm")
            Modes::CodeMakerMode.new(digits,range)
        else
            MasterMindToolBox::print_like_its_typed("invalid prompt")
            new_game(digits, range)
        end
        another_game?(digits,range)
    end 
end 
my_game = MasterMind.new()



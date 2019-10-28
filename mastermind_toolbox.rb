require 'colorize'
module MasterMindToolBox
    def self.print_like_its_typed(string)
        time_between_letters = 0.0
        time_between_words = 0.0
        time_between_dots = 0.0
        word_array = string.split(" ")
        word_array.each do |word|
            letter_array = word.chars
            letter_array.each do |letter|
                if(letter == ".")
                print ". ".green
                sleep(time_between_dots)
                else
                print letter.green
                sleep(time_between_letters)
                end 
            end 
            sleep(time_between_words)
            print " "
        end 
        print "\n"
    end 
    def self.get_hints(user_guess, secret_code)
        hint_array = []
        user_guess.each_with_index do |digit,index|
            if(digit == secret_code[index])#right number and position = green
                hint_array << "G"
            elsif(secret_code.include?(digit))#wrong position but right number 
                hint_array << "W"
            else
                hint_array << "R"#number not in secret code 
            end  
        end
    hint_array
    end
    def self.puts_hints(user_guess, hint_array)
        hint_array.each_with_index do |hint, index|
            number = user_guess[index].to_s
            case hint
            when "G"
                print number.green
            when "W"
                print number.white
            when "R"
                print number.red
            else 
                print "#{hint}:Error: hint does not exit".red
            end
        end
        print"\n"   
        sleep(0.1)
    end
    
    def self.create_code(ammount_of_digits, range)
        secret_code = []
        ammount_of_digits.times do 
            secret_code << rand(range)+1
        end
        secret_code
    end
    def self.get_code_from_user(digits,range)
        prompt = "Enter #{digits} digits between 1-#{range}\n"
        print_like_its_typed(prompt)
        user_input = gets.chomp
        if(user_input.match?(/[1-8]{#{digits}}/))
            return user_input.scan(/[1-#{range}]/)[0,digits].map{|e|e.to_i}
        else
            print_like_its_typed("invalid input")
             get_code_from_user(digits, range)
        end
    end 
end 
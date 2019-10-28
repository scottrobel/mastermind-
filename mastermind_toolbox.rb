require 'colorize'
module MasterMindToolBox
    def self.print_like_its_typed(string)
        time_between_letters = 0.02
        time_between_words = 0.04
        time_between_dots = 0.06
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
    def self.print_color_meanings
        puts "If the number is white the number exists inside the code but the number is not in the right place".white
        puts "If the number is green It is the right number in the right place".green
        puts "If the number is red the number is not inside the code".red
    end 
    def self.populate_possible_digits(digits, range)
        possible_digits_for_each_index = []
        digits.times do
            possible_digits_for_each_index.push((1 ..range).to_a)
        end 
        possible_digits_for_each_index
    end
    def self.select_randomly_from_possible_digits(possible_digits_for_each_index)
        possible_digits_for_each_index.map{|possible_digit_array| possible_digit_array.sample}
    end 
    def self.update_possible_digits(green_numbers, white_numbers,red_numbers,possible_digits_for_each_index)
        green_numbers.each do |key,value|
            possible_digits_for_each_index[key] = [value]
       end
       red_numbers.each do |key,value|
           possible_digits_for_each_index.map! do |possible_digits|
               possible_digits - [value]
           end 
       end 
       white_numbers.each do |key,value|
           possible_digits_for_each_index[key] = possible_digits_for_each_index[key] - [value]
           # possible_digits_for_each_index.map! do |array|
           #     if(array.include?(value))
           #         array << value
           #         array << value
           #     end
           #     array 
           # end 
       end
       return possible_digits_for_each_index
    end 
    def self.populate_color_hint_hashes(green_numbers,white_numbers,red_numbers,computer_guess,hints)
        hints.each_with_index do |hint,index|
            case hint
            when "G"
                green_numbers[index] = computer_guess[index]
            when "W"
                white_numbers[index] = computer_guess[index]
            when "R"
                red_numbers[index] = computer_guess[index]
            else 
            print "error" 
            end 
        end
        return green_numbers,white_numbers,red_numbers
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
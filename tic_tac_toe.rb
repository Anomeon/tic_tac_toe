data = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
player = 0
conditions_to_win = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

def clear_display
  system 'clear'
end

def draw_numbers_pad
  puts "| 1 | 2 | 3 |\n| 4 | 5 | 6 |\n| 7 | 8 | 9 |"
end

def ai(conditions_to_win, data, player)
  runs_x = []
  runs_o = []
  runs_empty = []
  conditions_to_win.each_with_index do |value, index|
    runs_x.push([])
    runs_o.push([])
    runs_empty.push([])
    value.each do |subvalue|
      if data[subvalue] == ' '
        runs_empty[index].push(subvalue)
      elsif data[subvalue] == 'x'
        runs_x[index].push(subvalue)
      else
        runs_o[index].push(subvalue)
      end
    end
  end
  runs_o.each_with_index do |sub_array, index|
    if (sub_array.length == 2) && (runs_empty[index].length != 0)
      data[runs_empty[index][0]] = 'o'
      return 0
    end
  end
  runs_x.each_with_index do |sub_array, index|
    if (sub_array.length == 2) && (runs_empty[index].length == 1)
      data[runs_empty[index][0]] = 'o'
      return 0
    end
  end
  runs_o.each_with_index do |sub_array, index|
    if (sub_array.length == 1) && (runs_empty[index].length == 2)
      data[runs_empty[index][rand().round]] = 'o'
      return 0
    end
  end
  x = true
  while x do
    random = rand(9)
    if data[random] == " "
      data[random] = 'o'
      x = false
    end
  end
end


def check_winner(conditions_to_win, data, player)
  conditions_to_win.each do |value|
    matches_x = 0
    matches_o = 0
      value.each do |subvalue|
        if data[subvalue] == 'x'
          matches_x += 1
        elsif data[subvalue] == "o"
          matches_o += 1
        end
      end
    if matches_x == 3
      puts "'x' выиграли!"
      exit
    elsif matches_o == 3
      puts "'o' выиграли!"
      exit
    elsif player == 9
      puts "Ничья!"
      exit      
    end
  end
end

def game_mode(clear_display)
  puts 'Играть с компьютером? y/n'
  answer = gets.chomp
  if answer == 'y'
    comp_enabled = true
  elsif answer == 'n'
    comp_enabled = false
  else
    clear_display
    game_mode(clear_display)
  end
  return comp_enabled
end

def check_input(data, player, conditions_to_win, comp_enabled)
  if (player % 2 != 0) && (comp_enabled == true)
    ai(conditions_to_win, data, player)
  else
    input = gets.to_i
    right_answer = false
    until right_answer do
      if input > 0 && input < 10 
        if data[input - 1] != " " 
          puts "В данную клетку уже был сделан ход, выберите другую клетку"
          input = gets.to_i
        else
          if player % 2 == 0
            data[input - 1] = "x"
          else
            data[input - 1] = "o"
          end
          right_answer = true
        end
      else
        puts "Введите цифру от 1 до 9"
        input = gets.to_i
      end
    end
  end
end

def draw_game_field(data)
  puts "| #{data[0]} | #{data[1]} | #{data[2]} |\n| #{data[3]} | #{data[4]} | #{data[5]} |\n| #{data[6]} | #{data[7]} | #{data[8]} |"
end

def game(data, player, check_winner, conditions_to_win, comp_enabled)
  clear_display
  print "\n"
  draw_numbers_pad
  
  print "\n"
  draw_game_field(data)
  
  check_input(data, player, conditions_to_win, comp_enabled)

  check_winner
  # ai(conditions_to_win, data, player)
  clear_display
end

comp_enabled = game_mode(clear_display)
while true do
  game(data, player, check_winner(conditions_to_win, data, player), conditions_to_win, comp_enabled)
  player += 1
end
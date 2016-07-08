require './global_requires'

puts 'I skip all input validation here, so it does not crowd the main solution. Please input carefully.'
print 'Please input TOP_X and TOP_Y, separated by space: '
top_string = gets
top_x, top_y = top_string.split(' ').map(&:to_i)

Rover.limit(top_x, top_y)

rovers = []
continue = 'c'

until continue.chomp != 'c'
  print 'Enter rover state with format "x y facing": '
  state = gets
  rover_data = state.chomp.split(' ')

  print 'Enter rover commands (only L, R and M allowed): '
  rover_commands = gets

  rovers << Rover.new(rover_data[0].to_i, rover_data[1].to_i, rover_data[2], rover_commands.chomp)

  print 'Press c + <Enter> to continue to enter new rover, or any other character to finish. '
  continue = gets
end

rovers.each do |rover|
  rover.run_all_commands
  puts(rover)
end
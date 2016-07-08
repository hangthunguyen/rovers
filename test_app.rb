require './global_requires'

# Test Input:
# 5 5
# 1 2 N
# LMLMLMLMM
# 3 3 E
# MMRMMRMRRM

# Expected Output:
# 1 3 N 
# 5 1 E

Rover.limit(5, 5)
@rover_1 = Rover.new(1, 2, 'N', 'LMLMLMLMM')
@rover_2 = Rover.new(3, 3, 'E', 'MMRMMRMRRM')

@rover_1.run_all_commands
@rover_2.run_all_commands

puts(@rover_1)
puts(@rover_2)
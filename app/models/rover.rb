class Rover
  attr_accessor :x, :y, :facing, :commands

  def self.limit(max_x, max_y)
    @@top_x = max_x
    @@top_y = max_y
  end

  CHANGES = {
    'L': { 'N': 'W', 'S': 'E', 'E': 'N', 'W': 'S' },

    'R': { 'N': 'E', 'S': 'W', 'E': 'S', 'W': 'N' },

    'M': {
        'N': { method: 'change_y', step:  1 },
        'S': { method: 'change_y', step: -1 },
        'E': { method: 'change_x', step:  1 },
        'W': { method: 'change_x', step: -1 },

      }
  }.with_indifferent_access

  def initialize(x_location, y_location, facing_direction, command_string)
    validate_params(x_location, y_location, facing_direction, command_string)

    @x = x_location
    @y = y_location
    @facing = facing_direction.upcase
    @commands = command_string.upcase.split('')

    # Pretend that 1000 is very big. We set them to default 1000, if there is no limit on the board.
    @@top_x = 1000 unless @@top_x 
    @@top_y = 1000 unless @@top_y
  end

  def change_x(step)
    return @x += step if (@x + step).between?(0, @@top_x)
    @x
  end

  def change_y(step)
    return @y += step if (@y + step).between?(0, @@top_y)
    @y
  end

  def run_command(command)
    mapping = CHANGES[command][@facing]
    return @facing = mapping if mapping.is_a? String
    self.send(mapping[:method], mapping[:step])
  end

  def run_all_commands
    @commands.each { |command| run_command(command) }
  end

  def to_s
    "#{@x} #{@y} #{@facing}"
  end

  def validate_params(x_location, y_location, facing_direction, command_string)
    errors = []
    errors << 'x must be an integer.' unless x_location.is_a? Fixnum
    errors << 'y must be an integer.' unless y_location.is_a? Fixnum
    errors << 'Facing must be N or S or E or W' unless ['N', 'S', 'E', 'W.'].include?(facing_direction.upcase)
    errors << 'Command string must content only L, R and M.' unless command_string =~ /^[LRM]+$/

    raise RuntimeError.new("Invalid data: #{errors.join(' ')}") unless  errors.empty?
    true
  end
end
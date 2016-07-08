require_relative '../spec_helper'

describe Rover do
  before :all do
    TOP_X = 15
    TOP_Y = 10
    Rover.limit(TOP_X, TOP_Y)
    @rover = Rover.new(4, 3, 'N', 'MLRMLRLR')
  end

  context 'change_x' do
    it 'decreases x by 1 if step is -1' do
      current_x = @rover.x
      expect(@rover.change_x(-1)).to eql(current_x - 1)
    end

    it 'increases x by 1 if step is  1' do
      current_x = @rover.x
      expect(@rover.change_x(1)).to eql(current_x + 1)
    end

    it 'does not decrease x if the negative move puts the rover out of boundary' do
      @rover.x  = 0
      current_x = @rover.x
      expect(@rover.change_x(-1)).to eql(current_x)
      expect(@rover.x).to eql(current_x)
    end

    it 'does not increase x if the positive move puts the rover out of boundary' do
      @rover.x  = TOP_X
      current_x = @rover.x
      expect(@rover.change_x(1)).to eql(current_x)
      expect(@rover.x).to eql(current_x)
    end
  end

  context 'change_y' do
    it 'decreases y by 1 if step is -1' do
      current_y = @rover.y
      expect(@rover.change_y(-1)).to eql(current_y - 1)
    end

    it 'increases y by 1 if step is  1' do
      current_y = @rover.y
      expect(@rover.change_y(1)).to eql(current_y + 1)
    end

    it 'does not decrease y if the negative move puts the rover out of boundary' do
      @rover.y  = 0
      current_y = @rover.y
      expect(@rover.change_y(-1)).to eql(current_y)
      expect(@rover.y).to eql(current_y)
    end

    it 'does not increase x if the positive move puts the rover out of boundary' do
      @rover.y  = TOP_Y
      current_y = @rover.y
      expect(@rover.change_y(1)).to eql(current_y)
      expect(@rover.y).to eql(current_y)
    end
  end

  context 'run_command' do
    it 'changes facing but does not change x and y when run L' do
      @rover.facing = 'N'
      current_x = @rover.x
      current_y = @rover.y
      @rover.run_command('L')

      expect(@rover.x).to eql(current_x)
      expect(@rover.y).to eql(current_y)
      expect(@rover.facing).to eql('W')

      expect(@rover.run_command('L')).to eql('S')
      expect(@rover.run_command('L')).to eql('E')
      expect(@rover.run_command('L')).to eql('N')
    end

    it 'changes facing but does not change x and y when run R' do
      @rover.facing = 'N'
      current_x = @rover.x
      current_y = @rover.y
      @rover.run_command('R')

      expect(@rover.x).to eql(current_x)
      expect(@rover.y).to eql(current_y)
      expect(@rover.facing).to eql('E')

      expect(@rover.run_command('R')).to eql('S')
      expect(@rover.run_command('R')).to eql('W')
      expect(@rover.run_command('R')).to eql('N')
    end

    it 'changes y by  1 when faces N and runs M' do
      @rover.facing = 'N'
      @rover.y = 3
      current_y = @rover.y
      current_facing = @rover.facing
      @rover.run_command('M')

      expect(@rover.y).to eql(current_y + 1)
      expect(@rover.facing).to eql(current_facing)
    end

    it 'changes y by -1 when faces S and runs M' do
      @rover.facing = 'S'
      @rover.y = 3
      current_y = @rover.y
      current_facing = @rover.facing
      @rover.run_command('M')

      expect(@rover.y).to eql(current_y - 1)
      expect(@rover.facing).to eql(current_facing)
    end

    it 'changes x by  1 when faces E and runs M' do
      @rover.facing = 'E'
      @rover.x = 4
      current_x = @rover.x
      current_facing = @rover.facing
      @rover.run_command('M')

      expect(@rover.x).to eql(current_x + 1)
      expect(@rover.facing).to eql(current_facing)
    end

    it 'changes x by -1 when faces W and runs M' do
      @rover.facing = 'W'
      @rover.x = 4
      current_x = @rover.x
      current_facing = @rover.facing
      @rover.run_command('M')

      expect(@rover.x).to eql(current_x - 1)
      expect(@rover.facing).to eql(current_facing)
    end

  end

  context 'validate_params' do
    it 'is not valid if x is not an integer' do
      expect { @rover.validate_params('a', 3, 'N', 'LRM') }.to raise_error(RuntimeError)
    end

    it 'is not valid if y is not an integer' do
      expect { @rover.validate_params(4, 0.5, 'N', 'LRM') }.to raise_error(RuntimeError)
    end

    it 'is not valid if the facing is not N or S or E or W' do
      expect { @rover.validate_params(4, 3, 'H', 'LRM') }.to raise_error(RuntimeError)
    end

    it 'is not valid if command string has anything different from L, R and M' do
       expect { @rover.validate_params(4, 3, 'N', 'LWM') }.to raise_error(RuntimeError)
    end

    it 'returns true if everything is valid' do
      expect(@rover.validate_params(4, 3, 'N', 'LRM')).to be true
    end
  end
  
end
maze_ary = STDIN.each_line.map(&:chomp)

# ここに処理を書いてください。

class MazeCell < String
end

class MazeStart < MazeCell
end

class MazeGoal < MazeCell
end

class MazeWall < MazeCell
end

class MazeSpace < MazeCell
end

class MazeAlready < MazeCell
end

class MazeCellFactory
  def self.create(str)
    case str
    when 'S' then
      return MazeStart.new(str)
    when 'G' then
      return MazeGoal.new(str)
    when '#' then
      return MazeWall.new(str)
    when ' ' then
      return MazeSpace.new(str)
    end
  end
end

class MazeRow < Array
end

class Maze < Array
  # 現在地から進める Cell がある場合に true を返す
  def going?(spot)
    i = spot[0]
    j = spot[1]
    going = false
    puts "#{i}, #{j}"
    if i > 0
      # 上探索
      puts "上探索"
      puts self[i-1][j]
      if self[i-1][j].is_a? MazeSpace
        going = true
      end
    end
    if i < self.length - 1
      # 下探索
      puts "下探索"
      puts self[i+1][j]
      if self[i+1][j].is_a? MazeSpace
        going = true
      end
    end
    if j > 0
      # 左探索
      puts "左探索"
      puts self[i][j-1]
      if self[i][j-1].is_a? MazeSpace
        going = true
      end
    end
    if j < self[i].length
      # 右探索
      puts "右探索"
      puts self[i][j+1]
      if self[i][j+1].is_a? MazeSpace
        going = true
      end
    end
    going
  end

  # 指定された位置へ移動する
  def next_spot(spot)
    i = spot[0]
    j = spot[1]
    puts "#{i}, #{j}"
    if i > 0
      # 上探索
      puts "上探索"
      puts self[i-1][j]
      if self[i-1][j].is_a? MazeSpace
        return [i-1, j]
      end
    end
    if i < self.length - 1
      # 下探索
      puts "下探索"
      puts self[i+1][j]
      if self[i+1][j].is_a? MazeSpace
        return [i+1, j]
      end
    end
    if j > 0
      # 左探索
      puts "左探索"
      puts self[i][j-1]
      if self[i][j-1].is_a? MazeSpace
        return [i, j-1]
      end
    end
    if j < self[i].length
      # 右探索
      puts "右探索"
      puts self[i][j+1]
      if self[i][j+1].is_a? MazeSpace
        return [i, j+1]
      end
    end
  end

  # 指定された位置の Cell を書き換える
  def already_spot(spot)
    self[spot[0]][spot[1]] = MazeAlready.new(";")
  end
end

start_spot = [0, 0]
maze_twod_ary = Maze.new

maze_ary.each_with_index do |row, row_i|
  _array = MazeRow.new
  row.enum_for(:each_char).each_with_index do |column, column_j|
    _array << MazeCellFactory.create(column)
    if column == 'S'
      start_spot = [row_i, column_j]
    end
  end
  maze_twod_ary << _array
end

# random_walk
current_spot = start_spot.dup
while(maze_twod_ary.going?(current_spot))
  current_spot = maze_twod_ary.next_spot(current_spot)
  maze_twod_ary.already_spot(current_spot)
end

maze_twod_ary.each do |maze_row|
  maze_row.each do |maze_cell|
    print maze_cell
  end
  print "\n"
end

puts(maze_ary)
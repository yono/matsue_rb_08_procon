maze_ary = STDIN.each_line.map(&:chomp)

# ここに処理を書いてください。

class MazeCell < String; end
class MazeStart < MazeCell; end
class MazeGoal < MazeCell; end
class MazeWall < MazeCell; end
class MazeSpace < MazeCell; end
class MazeRoute < MazeCell; end
class MazeAlready < MazeCell; end

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

class MazeRow < Array; end

class Maze < Array
  # 現在地から進める Cell がある場合に true を返す
  def goal?(spot)
    i = spot[0]
    j = spot[1]
    if i > 0
      # 上探索
      if self[i-1][j] == 'G'
        return true
      end
    end
    if i < self.length - 1
      # 下探索
      if self[i+1][j] == 'G'
        return true
      end
    end
    if j > 0
      # 左探索
      if self[i][j-1] == 'G'
        return true
      end
    end
    if j < self[i].length
      # 右探索
      if self[i][j+1] == 'G'
        return true
      end
    end
  end

  # 指定された位置へ移動する
  def next_spot(spot)
    i = spot[0]
    j = spot[1]
    if i > 0
      # 上探索
      if self[i-1][j] == ' '
        self[i-1][j] = MazeRoute.new(":")
        return [i-1,j]
      end
    end
    if i < self.length - 1
      # 下探索
      if self[i+1][j] == ' '
        self[i+1][j] = MazeRoute.new(":")
        return [i+1, j]
      end
    end
    if j > 0
      # 左探索
      if self[i][j-1] == ' '
        self[i][j-1] = MazeRoute.new(":")
        return [i,j-1]
      end
    end
    if j < self[i].length
      # 右探索
      if self[i][j+1] == ' '
        self[i][j+1] = MazeRoute.new(":")
        return [i,j+1]
      end
    end
    return_spot(spot)
  end

  # 来た道を戻って来た印を付ける
  def return_spot(spot)
    i = spot[0]
    j = spot[1]
    if i > 0
      # 上探索
      if self[i-1][j] == ':'
        self[i][j] = MazeAlready.new("*")
        return [i-1, j]
      end
    end
    if i < self.length - 1
      # 下探索
      if self[i+1][j] == ':'
        self[i][j] = MazeAlready.new("*")
        return [i+1, j]
      end
    end
    if j > 0
      # 左探索
      if self[i][j-1] == ':'
        self[i][j] = MazeAlready.new("*")
        return [i, j-1]
      end
    end
    if j < self[i].length
      # 右探索
      if self[i][j+1] == ':'
        self[i][j] = MazeAlready.new("*")
        return [i, j+1]
      end
    end
  end
end

start_spot = [0, 0]
maze_twod_ary = Maze.new

# オリジナル配列を探索用配列に置き換える
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

# 探索
current_spot = start_spot.dup
while(!maze_twod_ary.goal?(current_spot))
  current_spot = maze_twod_ary.next_spot(current_spot)
end

# 探索結果をオリジナル配列にコピーする
maze_twod_ary.each_with_index do |maze_row, i|
  maze_ary[i] = maze_row.join.tr('*', ' ')
end

puts(maze_ary)

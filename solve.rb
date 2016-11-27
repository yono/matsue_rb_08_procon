maze_ary = STDIN.each_line.map(&:chomp)

# ここに処理を書いてください。

class Maze
  def self.goal?(i, j, maze_ary)
    if i > 0
      # 上探索
      if maze_ary[i-1][j] == 'G'
        return true
      end
    end
    if i < maze_ary.length - 1
      # 下探索
      if maze_ary[i+1][j] == 'G'
        return true
      end
    end
    if j > 0
      # 左探索
      if maze_ary[i][j-1] == 'G'
        return true
      end
    end
    if j < maze_ary[i].length
      # 右探索
      if maze_ary[i][j+1] == 'G'
        return true
      end
    end
  end

  def self.next_spot(i, j, maze_ary)
    return_to_top = false
    return_to_bottom = false
    return_to_left = false
    return_to_right = false
    if i > 0
      # 上探索
      top = maze_ary[i-1][j]
      if top == ' '
        maze_ary[i-1][j] = ':'
        return i-1,j
      elsif top == ':'
        return_to_top = true
      end
    end
    if i < maze_ary.length - 1
      # 下探索
      bottom = maze_ary[i+1][j]
      if bottom == ' '
        maze_ary[i+1][j] = ':'
        return i+1, j
      elsif bottom == ':'
        return_to_bottom = true
      end
    end
    if j > 0
      # 左探索
      left = maze_ary[i][j-1]
      if left == ' '
        maze_ary[i][j-1] = ':'
        return i,j-1
      elsif left == ':'
        return_to_left = true
      end
    end
    if j < maze_ary[i].length
      # 右探索
      right = maze_ary[i][j+1]
      if right == ' '
        maze_ary[i][j+1] = ':'
        return i,j+1
      elsif right == ':'
        return_to_right = true
      end
    end
    maze_ary[i][j] = '*'
    if return_to_top
      return i-1, j
    elsif return_to_bottom
      return i+1, j
    elsif return_to_left
      return i, j-1
    else
      return i, j+1
    end
  end
end

start_i, start_j = 0, 0
#maze_twod_ary = Maze.new

maze_ary.each_with_index do |row, row_i|
  #_array = []
  row.enum_for(:each_char).each_with_index do |column, column_j|
    #_array << column
    if column == 'S'
      start_i = row_i
      start_j = column_j
    end
  end
  #maze_twod_ary << _array
end

current_i, current_j = start_i, start_j
while(!Maze.goal?(current_i, current_j, maze_ary))
  current_i, current_j = Maze.next_spot(current_i, current_j, maze_ary)
end

#maze_twod_ary.each_with_index do |maze_row, i|
#  maze_ary[i] = maze_row.join.tr('*', ' ')
#end

puts(maze_ary)

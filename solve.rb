maze_ary = STDIN.each_line.map(&:chomp)

# ここに処理を書いてください。

current_spot = [0, 0]
maze_twod_ary = []

maze_ary.each_with_index do |row, row_i|
  _array = []
  row.enum_for(:each_char).each_with_index do |column, column_j|
    _array << column
    if column == 'S'
      current_spot = [row_i, column_j]
    end
  end
  maze_twod_ary << _array
end

maze_twod_ary.each do |row|
  row.each do |column|
    puts "hoge #{column}"
  end
end

puts(maze_ary)

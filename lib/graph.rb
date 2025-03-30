require_relative "node"

class Knight
  attr_accessor :graph

  def initialize()
    @graph = populate_graph
    find_siblings
    puts @graph[4][3].siblings.to_s
  end

  def populate_graph()
    return Array.new(8) { |x|
      Array.new(8) { |y| Node.new([x, y]) }
    }
  end

  def find_siblings
    for array in @graph do
      for elem in array do
        find_siblings_helper(elem)
        # puts "done with iteration: #{elem}"
      end
    end
  end

  def find_siblings_helper(cur_elem)
    a = cur_elem.data[0]
    b = cur_elem.data[1]
    cur_elem.siblings = []

    for array in @graph do
      for elem in array do
        x = elem.data[0]
        y = elem.data[1]

        if (a == x + 1 || a == x - 1 ) && (b == y + 2 || b == y - 2)
          cur_elem.siblings << elem.data
        elsif (a == x + 2 || a == x - 2 ) && (b == y + 1 || b == y - 1)
          cur_elem.siblings << elem.data
        end
      end
    end
    return
  end

  def find(vertex)
    return nil if !vertex.kind_of?(Array)
    str = "#{vertex}" #> [4, 3]
    x = str[1].to_i #> "1"
    y = str[4].to_i #> "4"

    node = @graph[x][y]
    return node
  end

  def calc(vert_a, vert_b)
    return nil if !vert_a.kind_of?(Array) || !vert_b.kind_of?(Array)
    return nil if vert_a == vert_b
    node_a = find(vert_a)

    calc_helper(node_a, vert_b)

  end

  def calc_helper(current, vert_b, x_arr=[])
    sibling_index = 0
    sibling_array = current.siblings

    y_arr = []
    until current == vert_b
      sibling_array.each do |elem|
        return y_arr << elem if elem == vert_b
        next if x_arr.include?(elem)
        x_arr << elem if sibling_array[0] == elem
        y_arr << elem
      end
      if sibling_index < 7
        current = find(current.siblings[sibling_index])
        sibling_index += 1
      else
        return nil
      end
      y_arr = calc_helper(current, vert_b, x_arr)
    end
    return y_arr
  end


end



def t() @t end
@t = Knight.new

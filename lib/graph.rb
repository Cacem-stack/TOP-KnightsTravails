require_relative "node"
require "set"

class Knight
  attr_accessor :graph

  def initialize()
    @graph = populate_graph
    find_siblings
    #puts @graph[4][3].siblings.to_s
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

  def knight(st_vertex, en_vertex)
    root = find(st_vertex)
    visited_s = Set.new
    path = []
    #puts "vis: #{visited_s} path: #{path}"

    visited_s << root.data
    queue = []
    root.siblings.each { |sibling| queue << sibling }

    if root.data == en_vertex
      return { path: st_vertex }
    end

    until queue.length == 0
      for sibling in root.siblings
        #puts "root: #{root.data}"
        #puts "sibling: #{sibling}"
        if !find(sibling).parent && !visited_s.include?(sibling)
          find(sibling).parent = root.data
          #puts "parent: #{find(sibling).parent}"
        end
      end
      root = find(queue.shift)
      root.siblings.each { |sibling| queue << sibling }
      if root.data == en_vertex
        until !root.parent
          path.unshift(root.data)
          old = find(root.data)
          root = find(root.parent)
          old.parent = nil
        end
        path.unshift(root.data)
        puts "You made it to #{en_vertex} in #{path.length} moves."
        puts "Your path is #{path}"
        return { found: true, path: path }
      end
      visited_s << root.data
    end
    puts "No good"
    return { root: root }

  end


  def find(vertex)
    return nil if !vertex.kind_of?(Array)
    str = "#{vertex}" #> [4, 3]
    x = str[1].to_i #> "1"
    y = str[4].to_i #> "4"

    node = @graph[x][y]
    return node
  end

end

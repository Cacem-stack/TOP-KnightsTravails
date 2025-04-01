require_relative "node"

class Knight
  attr_accessor :graph

  def initialize()
    @graph = populate_graph
    @used_array = []
    find_siblings
    #puts @graph[4][3].siblings.to_s
  end

  def populate_graph
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
    x = str[1].to_i #> "4"
    y = str[4].to_i #> "3"

    node = @graph[x][y]
    return node
  end

  def no(int)
    str = int.to_s
    return nil if str.length != 2
    return @graph[str[0].to_i][str[1].to_i]
  end

  def traversal(start_vertex, target_vertex, org=find(start_vertex), used_nodes=[], path=[])
    node = find(start_vertex)

    return { path: nil, used_nodes: node.data } if used_nodes.include?(node.data)
    #path += [node.data] if node != org
    path += [node.data] if node != org

    if node.siblings.include?(target_vertex)
      path << target_vertex
      puts "\nopt 1\n\n"
      puts "Your Path is #{path} in #{path.length} move(s)"
      return { path: path, used_nodes: used_nodes }
    else
      #return { path: nil, used_nodes: used_nodes}
      used_nodes << node.data
    end

    if node == org
      node.siblings.each do |sibling|
        sibling_traversal_result = traversal(sibling, target_vertex, org, used_nodes, path) #> returns hash with :path, :used_array
        return sibling_traversal_result
        if !sibling_traversal_result[:path]
          used_nodes << sibling_traversal_result[:used_nodes]
        elsif sibling_traversal_result[:path]
          path = sibling_traversal_result[:path]
          puts "\nopt2\n\n"
          puts "Your Path is #{path} in #{path.length} move(s)"
          return path
        end
      end
    end


  end

end



def t() @t end
@t = Knight.new

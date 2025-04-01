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

  def testy(vertex=[4, 3], org=find(vertex))
    node = find(vertex)
    exit_cond = nil
    target = [4, 5]

    loop_i = 0
    i = 0

    if node == org
      @used_array = []
      print "#{node.siblings}\n"
      for sibling in node.siblings
        puts "This is sibling: #{sibling}"

        result = testy(sibling, org)
        return result if result
      end
      return nil
    end

    if org.siblings.include?(node.data)
      for sibling in node.siblings
        puts "This is nested sibling: #{sibling}"

        result = testy(sibling, org)
        return result if result
      end
      return nil
    end

    until exit_cond do
      puts "\niteration #{loop_i + 1}"
      loop_i += 1
      @used_array << node.data
      print "Node: "
      p node.data
      print "Target: "
      p target
      #print "Siblings: "
      #p node.siblings
      #print "@used_array "
      #p @used_array

      if node.data == target
        puts "MATCH!!!!"
        puts "MATCH!!!!"
        puts "MATCH!!!!"
        puts "MATCH!!!!"
        puts "MATCH!!!!"
        puts "MATCH!!!!"
        puts "MATCH!!!!"
        puts "MATCH!!!!"
        puts "MATCH!!!!"
        puts "MATCH!!!!"
        puts "MATCH!!!!"
        puts "MATCH!!!!"
        puts "MATCH!!!!"
        puts "MATCH!!!!"
        puts "Path: #{@used_array}\nMoves: #{loop_i}"
        return [@used_array, loop_i]
      end

      #puts "node.s.i: #{node.siblings[i]} node.s.i - 1: #{node.siblings[(i - 1)]}"
      #puts "t/f: #{i >= node.siblings.length}"
      until !@used_array.include?(node.siblings[i]) || !node do
        i += 1
        if i >= node.siblings.length - 1
          puts "No further options.\n\n"
          puts "Path: #{@used_array}\nMoves: #{loop_i}"
          exit_cond = true
        end
      end
      node = find(node.siblings[i])
      puts "i: #{i}"
      i = 0
    end
    puts "Couldn't find target: #{target}"
    return nil


  end

end



def t() @t end
@t = Knight.new

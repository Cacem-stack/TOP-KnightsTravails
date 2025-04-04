class Node
  attr_accessor :siblings, :data, :index, :parent

  def initialize(data)
    @data = data
    @siblings = nil
    @parent = nil
  end
end

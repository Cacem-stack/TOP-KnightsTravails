class Node
  attr_accessor :siblings, :data, :index

  def initialize(data)
    @data = data
    @siblings = nil
  end
end

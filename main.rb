require_relative "lib/graph.rb"

@test = Knight.new

@test.knight([0,0],[1,2])
@test.knight([0,0],[3,3])
@test.knight([3,3],[0,0])
@test.knight([0,0],[7,7])

def t() @test end

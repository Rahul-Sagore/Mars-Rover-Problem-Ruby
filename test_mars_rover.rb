require "./mars_rover_ruby_methods"
require "test/unit"

class TestMarsRovers < Test::Unit::TestCase
	$mission = MarsMission.new(5, 5)

	#MAIN TEST: Final position of Rover after completing inspection
  def test_rovers_control
  	rover1 = $mission.init_rovers(1, 2, "N", "LMLMLMLMM")
		rover2 = $mission.init_rovers(3, 3, "E", "MMRMMRMRRM")

    assert_equal("1, 3, N", $mission.control_rover(rover1))
    assert_equal("5, 1, E", $mission.control_rover(rover2))
  end

  # Testing the left/right moving direction of rover
  def test_change_rovers_direction
  	rover1 = $mission.init_rovers(1, 2, "N", "LMLMLMLMM")
		rover2 = $mission.init_rovers(3, 3, "E", "MMRMMRMRRM")

		# 'false' denotes the "L" turn and 'true' is for "R" turn.
		#       N
		# W			+			E
		#       S
		# Clockwise/anticlockwise movement for rover

  	assert_equal("W", $mission.change_direction(rover1, false))
  	assert_equal("N", $mission.change_direction(rover1, true))
  	assert_equal("E", $mission.change_direction(rover1, true))
  	assert_equal("S", $mission.change_direction(rover2, true))
  end

  #Moving Rover in the heading direction
  def test_move_rover
  	rover1 = $mission.init_rovers(1, 2, "N", "LMLMLMLMM")
		rover2 = $mission.init_rovers(3, 3, "E", "MMRMMRMRRM")

		assert_equal("1, 3", $mission.move_rover(rover1))
		assert_equal("4, 3", $mission.move_rover(rover2))
  end
 
end
class MarsMission # MAIN CLASS TO START THE MISSION
	DIRECTIONS = ["N", "E", "S", "W"]
	def initialize(x_upper, y_upper)
		@rovers = []
		@plateau = [x_upper, y_upper]
	end

	def init_rovers(x, y, head, controls) #INIT ROVER OBJECTS
		return { x: x, y: y, direction: head, controls: controls.split("") }
	end

	def control_rover(rover) #Direct the rover based on control
		rover[:controls].each { |status|
			update_position(rover, status)
		}
		return "#{rover[:x]}, #{rover[:y]}, #{rover[:direction]}"
	end

	def update_position(rover, current_control) # UPDATE ROVER's POSITION BASED ON STRING SENT BY NASA
		change_direction(rover, true) if current_control ==  "R"
		change_direction(rover, false) if current_control ==  "L"
		move_rover(rover) if current_control ==  "M"
	end

	def change_direction(rover, clockwise) # ROTATE ROVER BASED ON STRING SENT BY NASA
		direction_hash = Hash[DIRECTIONS.map.with_index.to_a]
		index = direction_hash[rover[:direction]]
		if clockwise #If "L" Move Rover anti clockwise in the direction
			index = (index.next == DIRECTIONS.size) ? 0 : index.next  # Reset index to 0 if it is the last element
		else
			index = (index == 0) ? (DIRECTIONS.size - 1) : index - 1
		end
		rover[:direction] = DIRECTIONS[index]
		return DIRECTIONS[index]
	end

	def move_rover(rover) #Move the Rover based on its direction
		case rover[:direction]
		when "N" then rover[:y] += 1
		when "E" then rover[:x] += 1
		when "S" then rover[:y] -= 1
		when "W" then rover[:x] -= 1
		end
		x_crossed = rover[:x] > @plateau[0] || rover[:x] < 0
		y_crossed = rover[:y] > @plateau[1] || rover[:y] < 0 
		raise "Rover moved out of the plane plateu" if x_crossed || y_crossed
		return "#{rover[:x]}, #{rover[:y]}"
	end
end

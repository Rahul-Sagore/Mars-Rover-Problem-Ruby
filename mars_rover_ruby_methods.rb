def input_to_array(is_word=nil) #GENERAL CLASS FOR TAKING INPUT AND CONVERTING TO ARRAY
	user_input = gets
	final_result = nil
	if(is_word)
		final_result = user_input.split("")
		final_result.delete_at(-1) if final_result[-1] == "\n"
	else
		if !user_input.nil?
			user_input = user_input.split(" ")
			final_result = user_input.each{|x| x }
		end
	end
	final_result
end

class MarsMission # MAIN CLASS TO START THE MISSION
	DIRECTIONS = ["N", "E", "S", "W"]

	def initialize()
		@rovers = []
	end

	def init_rovers(x, y, head, controls) #INIT ROVER INFO IN HASH
		return { x: x.to_i, y: y.to_i, direction: head, controls: controls }
	end

	def start
		@plateau = input_to_array()	
		while true
			pos = input_to_array()
			break if pos == [] || pos.nil?
			controls = input_to_array(true)
			pos.push controls
			@rovers.push(init_rovers(pos[0], pos[1], pos[2], pos[3]))
		end
		@rovers.each { |rover|
			control_rover(rover)
		}
	end

	def control_rover(rover) #Direct the rover based on control
		rover[:controls].each { |status|
			update_position(rover, status)
		}
		puts "#{rover[:x]}, #{rover[:y]}, #{rover[:direction]}"
	end

	def update_position(rover, current_control) # UPDATE ROVER's POSITION BASED ON STRING SENT BY NASA :D
		change_direction(rover, true) if current_control ==  "R"
		change_direction(rover, false) if current_control ==  "L"
		move_rover(rover) if current_control ==  "M"
	end

	def change_direction(rover, clockwise) # ROTATE ROVER BASED ON STRING SENT BY NASA :D
		# Getting index value of each direction value. 
		#Then change the index to next/prev index to point it to relevent direction
		direction_hash = Hash[DIRECTIONS.map.with_index.to_a]
		index = direction_hash[rover[:direction]] # Get index of current direction of the rover

		if clockwise #If "L", Move Rover anti clockwise in the direction, otherwise clockwise
			index = (index.next == DIRECTIONS.size) ? 0 : index.next  # Reset index to 0 if it is the last element
		else
			index = (index == 0) ? (DIRECTIONS.size - 1) : index - 1
		end
		rover[:direction] = DIRECTIONS[index] #Set New direction of the rover
		return DIRECTIONS[index]
	end

	def move_rover(rover) #MOVE THE ROVER IN THE HEADING DIRECTION
		case rover[:direction]
			when "N" then rover[:y] += 1
			when "E" then rover[:x] += 1
			when "S" then rover[:y] -= 1
			when "W" then rover[:x] -= 1
		end

		x_crossed = rover[:x] > @plateau[0].to_i || rover[:x] < 0
		y_crossed = rover[:y] > @plateau[1].to_i || rover[:y] < 0 
		raise "Rover moved out of the plane plateu" if (x_crossed || y_crossed)

		return "#{rover[:x]}, #{rover[:y]}"
	end
end

mission = MarsMission.new()
mission.start
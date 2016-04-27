def input_to_array(is_word=nil) #GENERAL CLASS FOR TAKING INPUT AND CONVERTING TO ARRAY
	user_input = gets.chomp
	if(is_word)
		final_result = user_input.split("")
	else
		user_input = user_input.split(" ")
		final_result = user_input.each{|x| x }
	end
	final_result
end

class MarsMission # MAIN CLASS TO START THE MISSION
	DIRECTIONS = ["N", "E", "S", "W"]

	def initialize()
		@rovers = []
		@plateau = []
	end

	def init_rovers(x, y, head, controls) #INIT ROVER OBJECTS
		return { x: x.to_i, y: y.to_i, direction: head, controls: controls}
	end

	def start() #START THE MISSION BY GETTING INFO OF ROVERS
		@plateau = input_to_array()

		while true
			pos = input_to_array()
			break if pos == []
			controls = input_to_array(true)
			pos.push controls
			@rovers.push(init_rovers(pos[0], pos[1], pos[2], pos[3]))
		end

		@rovers.each { |rover|
			control_rover(rover)
		}
	end

	def control_rover(rover)
		rover[:controls].each { |status|
			update_position(rover, status)
		}
		puts "#{rover[:x]}, #{rover[:y]}, #{rover[:direction]}"
	end

	def update_position(rover, current_control) # UPDATE ROVER's POSITION BASED ON STRING SENT BY NASA
		change_direction(rover, true) if current_control ==  "R"
		change_direction(rover, false) if current_control ==  "L"
		move_rover(rover) if current_control ==  "M"
	end

	def change_direction(rover, clockwise) # ROTATE ROVER BASED ON STRING SENT BY NASA
		direction_hash = Hash[DIRECTIONS.map.with_index.to_a]
		index = direction_hash[rover[:direction]]
		if clockwise
			index = (index.next == DIRECTIONS.size) ? 0 : index.next  # Reset index to 0 if it is the last element
			rover[:direction] = DIRECTIONS[index]
		else
			index = (index == 0) ? (DIRECTIONS.size - 1) : index - 1
			rover[:direction] = DIRECTIONS[index]
		end
	end

	def move_rover(rover)
		case rover[:direction]
		when "N" then rover[:y] += 1
		when "E" then rover[:x] += 1
		when "S" then rover[:y] -= 1
		when "W" then rover[:x] -= 1
		end
		x_crossed = rover[:x] > @plateau[0].to_i || rover[:x] < 0
		y_crossed = rover[:y] > @plateau[1].to_i || rover[:y] < 0 
		raise "Rover moved out of the plane plateu" if x_crossed || y_crossed
	end
end
new_mission = MarsMission.new()
new_mission.start
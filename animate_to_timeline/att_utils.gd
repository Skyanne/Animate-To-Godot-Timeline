tool
extends Node


func parse_atlas_xml(xml):

	var animate_xml_dictionaries = []

	var in_subtexture = false
	var in_frame_name = false
	var in_frame_x = false
	var in_frame_y = false
	var in_frame_width = false
	var in_frame_height = false

	var xml_parser = XMLParser.new()
	xml_parser.open(xml)

	var cur_parsed_line: int = 0

	while xml_parser.read() == OK:
		var node_type = xml_parser.get_node_type()
		var node_name = "Invalid"
		var node_data = "Invalid"
		match node_type:
			1:
				node_name = xml_parser.get_node_name()
			2:
				node_name = xml_parser.get_node_name()
			3:
				node_data = xml_parser.get_node_data()

		var frame_name
		var frame_x
		var frame_y
		var frame_width
		var frame_height

		for attribute_num in xml_parser.get_attribute_count():
			var attribute_name = xml_parser.get_attribute_name(attribute_num)
			var attribute_value = xml_parser.get_attribute_value(attribute_num)

			match attribute_name:

				"name":
					frame_name = attribute_value

				"x":
					frame_x = attribute_value

				"y":
					frame_y = attribute_value

				"width":
					frame_width = attribute_value

				"height":
					frame_height = attribute_value

					animate_xml_dictionaries.append({
						"name": frame_name,
						"x": frame_x,
						"y": frame_y,
						"width": frame_width,
						"height": frame_height
					})

	return animate_xml_dictionaries


# Atlas XML to timeline
func atlas_xml_to_timelines(xml_path, crop_buffer = Rect2(5, 5, 5, 10), animation_fps = int(24)):

	var dictionaries = parse_atlas_xml(xml_path)

	# Create animation array
	var animations: Dictionary = {}
	var added_animations = []

	# Assign frames to animation
	for dictionary in dictionaries:

		var frame_name: String = dictionary.get("name")
		frame_name.erase(frame_name.length() - 4, 4)

		var added: bool = false 

		# Add frame to animation dictionary
		for added_animation in added_animations:
			if frame_name == added_animation:
				animations[frame_name].append(dictionary)
				added = true

		# Create new entry in the dictionary
		if added == false:
			animations[frame_name] = [dictionary]
			added_animations.append(frame_name)
			added = true


	var animation_files = []

	for animation_key in animations.keys():

		# Create new animation
		var animation = Animation.new()

		# Create animation track
		var track_index = animation.add_track(Animation.TYPE_VALUE)

		# Remove interpolation
		animation.track_set_interpolation_type(track_index, Animation.INTERPOLATION_NEAREST)

		# Set property to animate
		animation.track_set_path(track_index, ".:region_rect")

		# Set step
		animation.step = 1.0 / animation_fps

		# Set Length
		animation.length = (1.0 / animation_fps) * animations[animation_key].size()
		
		# For each frame insert into animation
		var cur_frame = 0
		for frame in animations[animation_key]:

			# Set position for frame
			var anim_position = (1.0 / animation_fps) * cur_frame

			# Add frame
			animation.track_insert_key(track_index, anim_position, Rect2(float(frame.x) + crop_buffer.position.x, float(frame.y) + crop_buffer.position.y, float(frame.width) - crop_buffer.size.x, float(frame.height) - crop_buffer.size.y))
			cur_frame += 1
		
		animation_files.append({
			"name": animation_key,
			"data": animation
		})

	return animation_files

extends "res://Planets/Planet.gd"

func set_pixels(amount):
	$Land.material.set_shader_parameter("pixels", amount)
	$Craters.material.set_shader_parameter("pixels", amount)
	$LavaRivers.material.set_shader_parameter("pixels", amount)
	
	$Land.size = Vector2(amount, amount)
	$Craters.size = Vector2(amount, amount)
	$LavaRivers.size = Vector2(amount, amount)
	
func set_light(pos):
	$Land.material.set_shader_parameter("light_origin", pos)
	$Craters.material.set_shader_parameter("light_origin", pos)
	$LavaRivers.material.set_shader_parameter("light_origin", pos)

func set_seed(sd):
	var converted_seed = sd%1000/100.0
	$Land.material.set_shader_parameter("seed", converted_seed)
	$Craters.material.set_shader_parameter("seed", converted_seed)
	$LavaRivers.material.set_shader_parameter("seed", converted_seed)

func set_rotate(r):
	$Land.material.set_shader_parameter("rotation", r)
	$Craters.material.set_shader_parameter("rotation", r)
	$LavaRivers.material.set_shader_parameter("rotation", r)

func update_time(t):	
	$Land.material.set_shader_parameter("time", t * get_multiplier($Land.material) * 0.02)
	$Craters.material.set_shader_parameter("time", t * get_multiplier($Craters.material) * 0.02)
	$LavaRivers.material.set_shader_parameter("time", t * get_multiplier($LavaRivers.material) * 0.02)

func set_custom_time(t):
	$Land.material.set_shader_parameter("time", t * get_multiplier($Land.material))
	$Craters.material.set_shader_parameter("time", t * get_multiplier($Craters.material))
	$LavaRivers.material.set_shader_parameter("time", t * get_multiplier($LavaRivers.material))

func set_dither(d):
	$Land.material.set_shader_parameter("should_dither", d)

func get_dither():
	return $Land.material.get_shader_parameter("should_dither")

var color_vars1 = ["color1","color2","color3"]
var color_vars2 = ["color1","color2"]
var color_vars3 = ["color1","color2","color3"]

func get_colors():
	return (_get_colors_from_vars($Land.material, color_vars1)
	+ _get_colors_from_vars($Craters.material, color_vars2)
	+ _get_colors_from_vars($LavaRivers.material, color_vars3)
	)

func set_colors(colors):
	_set_colors_from_vars($Land.material, color_vars1, colors.slice(0, 3, 1))
	_set_colors_from_vars($Craters.material, color_vars2, colors.slice(3, 5, 1))
	_set_colors_from_vars($LavaRivers.material, color_vars3, colors.slice(5, 8, 1))

func randomize_colors():
	var seed_colors = _generate_new_colorscheme(randi()%3+2, randf_range(0.6, 1.0), randf_range(0.7, 0.8))
	var land_colors = []
	var lava_colors = []
	for i in 3:
		var new_col = seed_colors[0].darkened(i/3.0)
		land_colors.append(Color.from_hsv(new_col.h + (0.2 * (i/4.0)), new_col.s, new_col.v))
	
	for i in 3:
		var new_col = seed_colors[1].darkened(i/3.0)
		lava_colors.append(Color.from_hsv(new_col.h + (0.2 * (i/3.0)), new_col.s, new_col.v))

	set_colors(land_colors + [land_colors[1], land_colors[2]] + lava_colors)

class_name WaterFlower
extends Flower


@export_group("Components")
@export var water_component: WaterComponent


# Variables
var flowers_affecting_this: Array[WaterFlower] = []

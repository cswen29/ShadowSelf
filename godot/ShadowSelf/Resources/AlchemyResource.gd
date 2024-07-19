class_name AlchemyResource
extends Resource

enum Type {DOPAMINE,SEROTONIN,ENDORPHINS}

@export_group("Details")
@export var type: Type

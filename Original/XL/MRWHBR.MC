mrwhbr_begin
rqs_bridge_shape
	iwt r15,#mretail_shapestream&WM
	nop
rqs_bridge_vis
	iwt r15,#mretail_facevis&WM
	nop
rqs_bridge_packet
	iwt r15,#mretail_polygonall&WM
	nop
rqs_bridge_sprite
	iwt r15,#mretail_shapespritegate&WM
	nop
rqs_return29
	iwt r13,#rqs_return30>>16
	iwt r12,#rqs_return30&WM
	from r12
	ljmp r13
	nop
mrwhbr_end

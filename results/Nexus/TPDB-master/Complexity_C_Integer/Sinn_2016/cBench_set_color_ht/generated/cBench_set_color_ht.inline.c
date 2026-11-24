//taken from office_ghostscript/src/gxcht.c 	set_color_ht	1703,1695,1674,1668

//Complexity: O(n^2)
void set_color_ht_extracted(int h, int w) {
    for (int y = h; ;) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
	--y;
	for (int x = w; x > 0;) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
		int nx = (((x) < (8)) ? (x) : (8));
		x -= nx;
		for (int i = nx; --i >= 0; ){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_2" ::: "memory"); ; } 
	}
	if (y <= 0)
	    break;
    }
}



int nondet();

int aaron12(int x,int y,int z) {
	while (x>=y) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
		if (nondet()>0) {
			x=x+1;
			y=y+x;


		} else {
			x=x-z;
			y=y+(z*z);
			z=z-1;

		}


	}
	{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }



}

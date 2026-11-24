extern int __VERIFIER_nondet_int(void);

int foo(int x,int y,int z){
if (x <= 10000 && x >= -10000 && y <= 10000 && z <= 10000) {
	    while (y >= 1) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
		    x = x - 1;
		    while (y < z) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
			    x = x + 1;
			    z = z - 1;
		    }
	    	y = x + y;
    	}
	}
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


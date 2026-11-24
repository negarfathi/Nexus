extern int __VERIFIER_nondet_int(void);

int foo(int x,int y,int z,int i){
z = 0;
i = x;
if (y > 0 && x > 0) {
    	while (i > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
	    	i = i - 1;
		    z = z + 1;
	    }
    	while (i < y) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); 
	    	i = i + 1;
		    z = z - 1;
	    }
	}
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


extern int __VERIFIER_nondet_int(void);

int foo(int x,int y,int z){
if (2*y >= z) {
    	while (x >= 0 && z == 1) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
	    	x = x - 2*y + 1;
	    }
	}
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


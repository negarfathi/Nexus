extern int __VERIFIER_nondet_int(void);

int foo(int c,int x){
if (c >= 2) {
	    while (x + c >= 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
		    x = x - c;
		    c = c + 1;
	    }
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


extern int __VERIFIER_nondet_int(void);

int foo(int x){
while (x != 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
		if (x > 0) {
			x = x - 1;
		} else {
			x = x + 1;
		}
	}
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


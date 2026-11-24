extern int __VERIFIER_nondet_int(void);

int foo(int x){
while (x <= 100) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
		if (__VERIFIER_nondet_int() != 0) {
			x = -2*x + 2;
		} else {
			x = -3*x - 2;
		}
	}
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


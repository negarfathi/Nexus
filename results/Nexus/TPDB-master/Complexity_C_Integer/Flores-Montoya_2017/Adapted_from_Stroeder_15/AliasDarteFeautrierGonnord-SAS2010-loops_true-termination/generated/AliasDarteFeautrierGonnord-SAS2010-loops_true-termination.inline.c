extern int __VERIFIER_nondet_int(void);

int foo(int x,int y,int n){
x = n;
if (x >= 0) {
		while (x >= 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
			y = 1;
			if (y < x) {
				while (y < x) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
					y = 2*y;
                }
			}
			x = x - 1;
		}
	}
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


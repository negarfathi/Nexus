extern int __VERIFIER_nondet_int(void);

int foo(int x,int y){
if (x >= 0 && y >= 0) {
		while (x - y > 2 || y - x > 2) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
			if (x < y) {
				x = x + 1;
			} else {
				y = y + 1;
			}
		}
	}
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


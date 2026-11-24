extern int __VERIFIER_nondet_int(void);

int foo(int x,int y,int oldx,int oldy){
while (x > 0 && y > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
		oldx = x;
		oldy = y;
		if (__VERIFIER_nondet_int() != 0) {
			x = oldx - 1;
			y = oldx;
		} else {
			x = oldy - 2;
			y = oldx + 1;
		}
	}
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


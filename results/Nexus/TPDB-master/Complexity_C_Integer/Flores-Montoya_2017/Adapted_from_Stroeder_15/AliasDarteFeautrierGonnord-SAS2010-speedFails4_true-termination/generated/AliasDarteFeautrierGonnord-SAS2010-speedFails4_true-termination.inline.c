extern int __VERIFIER_nondet_int(void);

int foo(int i,int x,int n,int b,int t){
if (b >= 1) {
		t = 1;
	} else {
		t = -1;
    }
while (x <= n) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
		if (b >= 1) {
			x = x + t;
		} else {
			x = x - t;
		}
	}
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


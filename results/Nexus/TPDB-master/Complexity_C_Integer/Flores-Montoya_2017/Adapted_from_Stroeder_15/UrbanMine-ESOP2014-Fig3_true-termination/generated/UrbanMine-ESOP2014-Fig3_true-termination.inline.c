extern int __VERIFIER_nondet_int(void);

int foo(int x,int y){
while (x != 0 && y > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
	    if (x > 0) {
		    if (__VERIFIER_nondet_int() != 0) {
			    x = x - 1;
				y = __VERIFIER_nondet_int();
			} else {
			    y = y - 1;
			}
		} else {
		    if (__VERIFIER_nondet_int() != 0) {
			    x = x + 1;
			} else {
			    y = y - 1;
				x = __VERIFIER_nondet_int();
			}		
		}
	}
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


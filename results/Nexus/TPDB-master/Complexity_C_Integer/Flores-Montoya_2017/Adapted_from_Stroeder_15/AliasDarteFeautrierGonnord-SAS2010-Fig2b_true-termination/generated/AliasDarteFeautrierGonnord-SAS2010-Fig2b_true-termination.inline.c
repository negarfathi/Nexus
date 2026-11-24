extern int __VERIFIER_nondet_int(void);

int foo(int x,int y){
while (x >= 2) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
		x = x - 1;
        y = y + x;
		while (y >= x + 1 && __VERIFIER_nondet_int() != 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
			y = y - 1;
			while (y >= x + 3 && __VERIFIER_nondet_int() != 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_2" ::: "memory"); 
				x = x + 1;
                y = y - 2;
			}
			y = y - 1;
		}
		x = x - 1;
        y = y - x;
	}
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


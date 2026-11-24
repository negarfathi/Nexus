extern int __VERIFIER_nondet_int(void);

int foo(int r,int x,int y){
if (x<0) {x = -x;}
if (y<0) {y = -y;}
while (y>0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
		
		r = x;
		while (r>=y) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
			r = r-y;
        }
		
		x = y;
		y = r;
	}
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


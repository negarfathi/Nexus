extern int __VERIFIER_nondet_int(void);

int foo(int x,int y,int z){
y = 100;
z = 1;
while (x >= 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
		x = x - y;
		y = y - z;
		z = -z;
	}
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


extern int __VERIFIER_nondet_int(void);

int foo(int x,int y,int oldx){
while (4*x + y > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        oldx = x;
        x = -2*oldx + 4*y;
        y = 4*oldx;
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


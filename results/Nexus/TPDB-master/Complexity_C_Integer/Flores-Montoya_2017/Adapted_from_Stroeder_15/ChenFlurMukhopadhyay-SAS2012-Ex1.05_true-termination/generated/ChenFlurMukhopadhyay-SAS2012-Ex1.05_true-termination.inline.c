extern int __VERIFIER_nondet_int(void);

int foo(int x,int oldx){
while (x > 0 && 2*x <= oldx) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        oldx = x;
        x = __VERIFIER_nondet_int();
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


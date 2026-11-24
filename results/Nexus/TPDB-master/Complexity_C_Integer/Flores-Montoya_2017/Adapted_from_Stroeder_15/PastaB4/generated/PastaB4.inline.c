extern int __VERIFIER_nondet_int(void);

int foo(int x,int y,int t){
while (x > y) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        t = x;
        x = y;
        y = t;
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


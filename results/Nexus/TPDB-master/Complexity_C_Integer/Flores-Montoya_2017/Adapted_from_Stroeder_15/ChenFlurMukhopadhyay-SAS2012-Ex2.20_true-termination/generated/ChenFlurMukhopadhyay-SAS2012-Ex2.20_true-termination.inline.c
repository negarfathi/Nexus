extern int __VERIFIER_nondet_int(void);

int foo(int x,int y){
while (x > y && y >= 1 && y <= 2) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        x = x - y;
        y = __VERIFIER_nondet_int();
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


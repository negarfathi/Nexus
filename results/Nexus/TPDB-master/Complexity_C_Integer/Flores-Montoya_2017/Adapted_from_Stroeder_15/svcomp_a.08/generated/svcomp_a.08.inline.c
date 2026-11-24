extern int __VERIFIER_nondet_int(void);

int foo(int c,int x,int y){
c = 0;
while (x > y) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        x = x + 1;
        y = y + 2;
        c = c + 1;
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


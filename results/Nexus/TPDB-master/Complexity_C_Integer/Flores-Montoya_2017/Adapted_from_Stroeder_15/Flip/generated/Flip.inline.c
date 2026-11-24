extern int __VERIFIER_nondet_int(void);

int foo(int i,int j,int t){
t = 0;
while (i != 0 && j != 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        t = i;
        i = j;
        j = t;
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


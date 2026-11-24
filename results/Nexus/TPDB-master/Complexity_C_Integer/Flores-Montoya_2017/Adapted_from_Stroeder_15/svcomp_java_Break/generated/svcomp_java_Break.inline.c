extern int __VERIFIER_nondet_int(void);

int foo(int i,int c){
i = 0;
c = 0;
while (i <= 10) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        i = i + 1;
        c = c + 1;
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


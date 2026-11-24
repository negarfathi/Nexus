extern int __VERIFIER_nondet_int(void);

int foo(int x1,int x2){
while (x1 <= 10) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        x2 = 1000;
        while (x2 > 1) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
            x2 = x2 -1;
        }
        x1 = x1 + 1;
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


extern int __VERIFIER_nondet_int(void);

int foo(int i){
while (i > 10) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        if (i == 25) {
            i = 30;
        }
        if (i <= 30) {
            i = i-1;
        } else {
            i = 20;
        }
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


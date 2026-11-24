extern int __VERIFIER_nondet_int(void);

int foo(int i){
while (i > 0 && i < 50) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        if (i < 20) {
            i = i-1;
        }
        if (i > 10) {
            i = i+1;
        }
        if (30 <= i && i <= 40) {
            i = i-1;
        }
        
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


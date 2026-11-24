extern int __VERIFIER_nondet_int(void);

int foo(int c,int i){
c = (24*6)*6;
if (c <= 10) {
        i = 0;
        while (i < 100) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
            i = i+1;
        }
    }
    else {
        if (c <= 50) {
            i = 0;
            while (i < 101) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); 
                i = i+1;
            }
        }
        if (c <= 100) {
            i = 0;
            while (i < 102) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_0" ::: "memory"); 
                i = i+1;
            }
        }
        else {
            i = 0;
            while (i < 103) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_4_PARENT_0" ::: "memory"); 
                i = i+0;
            }
        }
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


extern int __VERIFIER_nondet_int(void);

int foo(int x,int y,int tmp,int xtmp){
while(y > 0 && x > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        tmp = y;
        xtmp = x;
        
        if(y == 0) {
            y = y;
        }
        else {
            if(y < 0) {
                xtmp = -xtmp;
            }
        }
        if(xtmp > 0) {
            while(xtmp>=y) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
                xtmp = xtmp - y;
            }
            y = xtmp;
        } else {
            while(xtmp < 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_1" ::: "memory"); 
                xtmp = xtmp - y;
            }
            y = xtmp;
        }
        
        x = tmp;
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


extern int __VERIFIER_nondet_int(void);

int foo(int id,int maxId,int tmp){
if(0 <= id && id < maxId) {
        tmp = id+1;
        while(tmp!=id && __VERIFIER_nondet_int() != 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
            if (tmp <= maxId) {
                tmp = tmp + 1;
            } else {
                tmp = 0;
            }
        }
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


typedef enum {false,true} bool;

extern int __VERIFIER_nondet_int(void);

int main() {
    int i;
    int j;
    int t;
    i = __VERIFIER_nondet_int();
    j = __VERIFIER_nondet_int();
    t = 0;
    
    while (i > 0 && j > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        if (i < j) {
            t = i;
            i = j;
            j = t;
        } else {
            if (i > j) {
                j = i;
            } else {
                i = i-1;
            }
        }
    }
    
    { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

typedef enum {false,true} bool;

extern int __VERIFIER_nondet_int(void);

int main() {
    int i;
    int w;
    i = __VERIFIER_nondet_int();
    w = 5;
    
    while (i != 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        if (i < -w) {
            i = i-1;
            i = i*(-1);
        } else {
            if (i > w) {
                i = i+1;
                i = i*(-1);
            } else {
                i = 0;
            }
        }
    }
    
    { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

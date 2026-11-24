typedef enum { false, true } bool;

extern int __VERIFIER_nondet_int(void);

int main() {
    int i;
    int range;
    int up;
    i = __VERIFIER_nondet_int();
    range = 20;
    up = 0;
    
    while (0 <= i && i <= range) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        if (i == 0) {
            up = 1;
        }
        if (i == range) {
            up = 0;
        }
        if (up == 1) {
            i = i+1;
        }
        if (up == 0) {
            i = i-1;
        }
        if (i == range-2) {
            range = range-1;
        }
    }
    
    { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

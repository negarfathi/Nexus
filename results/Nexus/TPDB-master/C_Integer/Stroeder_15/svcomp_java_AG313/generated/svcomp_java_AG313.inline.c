typedef enum {false, true} bool;

extern int __VERIFIER_nondet_int(void);

int main() {
    int i, x, y;
    i = 0;
    x = __VERIFIER_nondet_int();
    y = __VERIFIER_nondet_int();
    if (x!=0) {
        while (x > 0 && y > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
            i = i + 1;
            x = (x - 1)- (y - 1);
        }
    }
    { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

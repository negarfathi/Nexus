typedef enum {false, true} bool;

extern int __VERIFIER_nondet_int(void);

int main() {
    int flag;
    int c, x, y;
    flag = 1;
    c = 0;
    x = __VERIFIER_nondet_int();
    y = __VERIFIER_nondet_int();
    while (flag != 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        if (x >= y) {
            flag = 0;
        }
        x = x + 1;
        c = c + 1;
    }
    { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

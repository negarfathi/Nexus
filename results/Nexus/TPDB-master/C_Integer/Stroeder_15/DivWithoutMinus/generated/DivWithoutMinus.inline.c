typedef enum {false,true} bool;

extern int __VERIFIER_nondet_int(void);

int main() {
    int x;
    int y;
    int z;
    int res;
    x = __VERIFIER_nondet_int();
    y = __VERIFIER_nondet_int();
    z = y;
    res = 0;
    
    while (z > 0 && (y == 0 || y > 0 && x > 0))	{ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        
        if (y == 0) {
            res = res + 1;
            y = z;
        }
        else {
            x = x + 1;
            y = y - 1;
        }
    }
    
    { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


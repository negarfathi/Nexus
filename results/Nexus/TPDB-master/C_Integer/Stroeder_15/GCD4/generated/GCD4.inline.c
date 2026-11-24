typedef enum {false,true} bool;

extern int __VERIFIER_nondet_int(void);

int main() {
    int x;
    int y;
    int tmp;
    int xtmp;
    x = __VERIFIER_nondet_int();
    y = __VERIFIER_nondet_int();
    
    while(y > 0 && x > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        tmp = y;
        xtmp = x;
        
        while(xtmp>=y && y > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
            xtmp = xtmp - y;
        }
        
        y = xtmp;
        x = tmp;
    }
    
    { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
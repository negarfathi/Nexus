typedef enum {false,true} bool;

extern int __VERIFIER_nondet_int(void);

int main() {
    int i;
    int j;
    i = 0;
    j = 5;
    
    while (i < 100) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory");  i = i+1; }
    
    while (j < 21) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory");  j = j+3; }
    
    { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

typedef enum {false,true} bool;

extern int __VERIFIER_nondet_int(void);

int main() {
    int j;
    int i;
    int fac;
    j = __VERIFIER_nondet_int();
    i = 1;
    fac = 1;
    
    while (fac != j) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        fac = fac * i;
        i = i+1;
    }
	
    { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

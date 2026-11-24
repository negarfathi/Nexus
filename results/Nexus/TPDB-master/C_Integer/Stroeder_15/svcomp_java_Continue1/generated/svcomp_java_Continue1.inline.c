typedef enum {false, true} bool;

extern int __VERIFIER_nondet_int(void);

int main() {
	int i;
    int c;
	i = 0;
    c = 0;
	while (i < 20) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
	    i = i + 1;
	    if (i <= 10) {
        } else {
            c = c + 1;
        }
	}
    { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

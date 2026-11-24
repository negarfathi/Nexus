//taken from SPEC CPU2006	hmmer/src/masks.c 	XNU

int nondet();

//O(n)
void xnu(int len) {
    int beg = 0;
    int end = 0;
    int i = 0;
    while (i < len) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        i++;
        if (nondet())
            end = i;
        if (nondet()) {
            int k = beg;
            while (k < end)
                { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); k++; }
            end = i;
            beg = end;
        } else if (nondet()) {
            end = i;
            beg = end;
        }
    }
} 


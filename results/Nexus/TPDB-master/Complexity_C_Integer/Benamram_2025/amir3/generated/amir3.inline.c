/*
 * Example for complexity analysis
 * Contributed by Amir ben-Amram, june 2025
 */
 extern int nondet();

void amir3(int x5, int x1, int x2)
{
    int x3 = 0;
    int x4 = 0;
    while (x5-- > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        if (nondet()) {
            x3 = x1+x2;
            x4 = x2;
        }  else {
            x3 = x2;
            x4 = x1+x2;
        }
        x1 = x3+x4;
    }
    while (x1 > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); 
        x1--;
    }
}

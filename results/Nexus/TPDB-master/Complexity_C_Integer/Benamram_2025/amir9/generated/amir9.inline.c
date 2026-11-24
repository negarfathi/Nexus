/*
 * Example for complexity analysis
 * Contributed by Amir ben-Amram, june 2025
 */
 extern int nondet();

void amir9(int x1, int x2, int x3)
{
    int x4 = 0;
    while (x3-- > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        x2 = x2+x4;
        x4 = x3;
        if (nondet()) {
            x1 = x1+x3;
        } else {
         x2 = x2+x3;
        }
    }
    while (x2 > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); 
        x2--;
    }
}

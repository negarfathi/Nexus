/*
 * Example for complexity analysis
 * Contributed by Amir ben-Amram, june 2025
 */
 extern int nondet();

void amir13(int x3, int x7)
{
    int i;
    int x4 = 0;
    int x1 = 0;
    int x2 = 0;
    int x5 = 0;
    while (x7-- > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        for (i=0; i<x7; i++) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
            for (i=0; i<x3; i++) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_2" ::: "memory"); 
                x4 = x1;
                x1 = x2+1;
                x2 = x4;
            }
            x5 = x5+x1;
            x3 = x1;
        }
        x3 += x5;
    }
    while (x3 > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_4_PARENT_0" ::: "memory"); 
        x3--;
    }
}

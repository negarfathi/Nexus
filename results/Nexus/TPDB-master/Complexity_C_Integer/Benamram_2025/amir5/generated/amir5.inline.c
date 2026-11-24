/*
 * Example for complexity analysis
 * Contributed by Amir ben-Amram, june 2025
 */
 
void amir5(int x4, int x1, int x2, int x5)
{
    int i;
    int x3 = 0;
    while (x5-- > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        for (i=0; i<x4; i++) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
            x2 = x1+x2;
            x3 = x2;
        }
         x2 = x1;
         x4 = x3;
    }
    while (x4 > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_0" ::: "memory"); 
        x4--;
    }
}

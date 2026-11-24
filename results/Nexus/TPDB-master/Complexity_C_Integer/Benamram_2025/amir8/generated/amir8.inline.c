/*
 * Example for complexity analysis
 * Contributed by Amir ben-Amram, june 2025
 */

void amir8(int L1, int L2, int X, int Y)
{
    int A, B, i;
    int R1 = 0;
    int R2 = 0;
    while ( L2-- > 0 ) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        A = X; B = Y;
        for (i=0; i<L1; i++) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
            int tmp=A;
            B = A;
            A = tmp;
        }
        R1 = A;
        A = Y;
        B = X;
        for (i=0; i<L1; i++) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_1" ::: "memory"); 
            int tmp=A;
            B = A;
            A = tmp;
        }
        R2 = A;
        X =  R1 +R2;
    }
    while (X>0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_4_PARENT_0" ::: "memory"); X-- ; }
}
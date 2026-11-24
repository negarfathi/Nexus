/*
 * Example for complexity analysis
 * Contributed by Amir ben-Amram, june 2025
 */

int loop(int x1, int x2, int x3, int x4) {
  while(x2 > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    if (x1 > 0) {
      x1 = x1-2;
      x4++;
      x3 = x4;
      while (x3 > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
        x2 += x3;
        x3-- ;
      }
    } else {
      x2-- ;
      x1 = -x1-2; 
    }
  }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

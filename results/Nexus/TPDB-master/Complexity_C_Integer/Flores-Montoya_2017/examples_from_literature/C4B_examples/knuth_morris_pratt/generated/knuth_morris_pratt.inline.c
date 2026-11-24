/* Knuth-Morris-Pratt string searching */
int nondet();

int knuth_morris_pratt(int n, int m)
{
  int i = 0, j = 0, k = -1;

  while (i < n)
  { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    while (j >= 0 && nondet()>0 ) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
       k = nondet();
       if (k <= 0) { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_2_IDS_1_2" ::: "memory"); return 0; }
       if (k >0) { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_2_IDS_1_2" ::: "memory"); return 0; }
       j -= k;
    }
    i++, j++;
    if (j == m)
        break;
  }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return i; }
}


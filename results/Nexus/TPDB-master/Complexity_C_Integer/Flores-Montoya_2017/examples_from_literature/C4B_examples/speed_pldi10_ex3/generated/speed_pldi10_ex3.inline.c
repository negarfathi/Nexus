int nondet();

void speed_pldi10_ex3(int n)
{
  while (n>0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    n=n-1;
    while (n>0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
      if (nondet()>0) break;
      n=n-1;
    }
  }
}


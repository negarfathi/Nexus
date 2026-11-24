int nondet();

void speed_popl10_sequential_single(int n)
{
  int x=0;

  while (x<n) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    if (nondet()>0) break;
    x=x+1;
  }
  while (x<n)
    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); x=x+1; }
}


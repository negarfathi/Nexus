int nondet();

void speed_popl10_simple_single(int n)
{
  int x=0;

  while (x<n) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    if (nondet()>0)
      x=x+1;
    else 
      x=x+1;
  }
}


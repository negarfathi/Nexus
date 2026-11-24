int nondet();

void t13(int x, int y)
{
  while (x > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    x=x-1;
    if (nondet()>0) 
      y=y+1;
    else
      while (y > 0)
        { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); y=y-1; }
  }
}


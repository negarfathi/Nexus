int nondet();

void t10(int x, int y)
{
  while (x>y) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    if (nondet()>0)
      y=y+1;
    else
      x=x-1;
  }
}


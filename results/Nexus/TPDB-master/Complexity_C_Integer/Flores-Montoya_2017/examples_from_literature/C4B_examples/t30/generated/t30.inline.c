void t30(int x, int y)
{
  int t=0;

  while (x>0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    x--;
    t=x, x=y, y=t;
  }
}


void speed_pldi09_fig1(int n)
{
  int x=0;
  int y=0;

  for (;;) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    if (x < n) {
      y=y+1;
      x=x+1;
    } else if (y > 0)
      y=y-1;
    else
      break;
  }
}


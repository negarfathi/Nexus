void t47(int n)
{
  int flag = 1;

  while (flag>0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    if (n>0) {
      n--;
      flag=1;
    } else
      flag=0;
  }
}


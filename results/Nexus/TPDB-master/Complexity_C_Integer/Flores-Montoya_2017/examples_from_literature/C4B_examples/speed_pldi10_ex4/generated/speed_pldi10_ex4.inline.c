void speed_pldi10_ex4(int n)
{
  int flag=1;

  while (flag>0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    flag=0;
    while (n>0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
      n=n-1;       
      flag=1;
    }
  }
}


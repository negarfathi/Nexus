

int nondet();

void speed_pldi10_ex1(int n)
{
  int i;
  int j;

  i=0;
  while (i<n) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    j=i+1;
    while (j<n) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
      if (nondet()>0) {
        j=j-1;
        n=n-1;
      }
      j=j+1;
    }
    i=i+1;
  }
}


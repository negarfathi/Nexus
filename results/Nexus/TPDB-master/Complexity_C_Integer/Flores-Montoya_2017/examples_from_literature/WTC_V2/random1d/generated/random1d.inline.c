int nondet();

void random1d(int max) {
  int a,x;
  if (max>0) {
  a=0;
  x=1;
  while (x<=max) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    if (nondet()>0) a=a+1; else a=a-1;
    x=x+1;
  }
  }

}

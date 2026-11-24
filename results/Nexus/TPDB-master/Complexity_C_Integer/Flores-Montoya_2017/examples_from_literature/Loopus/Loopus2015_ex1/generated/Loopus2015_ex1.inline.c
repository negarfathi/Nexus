

int nondet();

void Loopus2015_ex1(int n) {
 int x = n;
 int r = 0;
 while(x > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
  x = x - 1;
  r = r + 1;
  if(nondet()>0) {
   int p = r;
   while(p > 0)
     { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); p--; }
   r = 0;
  }
 } 
}



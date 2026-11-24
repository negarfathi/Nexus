
int nondet();

void Loopus2015_ex2(int n, int m1,int m2) {
 if(n<0) { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return; }
 if(m1<0) { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return; }
 if(m2<0) { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return; }
 int y = n;
 int x;
 if(nondet()>0)
    x = m1;
 else
  x = m2;
 while(y > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
   y--;
   x = x + 2; 
  }
 int z = x;
  while(z > 0)
   { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); z--; } 
}




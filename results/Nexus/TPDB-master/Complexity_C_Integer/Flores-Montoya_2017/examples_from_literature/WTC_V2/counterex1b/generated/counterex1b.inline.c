int nondet();

void counterex1b(int n,int x,int y)
{

  while(x>=0){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    while(y>=0 && nondet()>0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); y--; }
    x--;
    while(y<=n && nondet()>0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_1" ::: "memory"); y++; }
  }
}

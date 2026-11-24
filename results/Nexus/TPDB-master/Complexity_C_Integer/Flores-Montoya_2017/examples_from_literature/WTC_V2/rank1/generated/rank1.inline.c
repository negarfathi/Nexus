
int nondet();

void rank1(int m)
{
int y= 0;
int x = m;
while(x>=0 && y>=0){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
if(nondet()>0){
   while(y <= m && nondet()>0)
   { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); y++; }
   x--;
  }
  y--;
}
}



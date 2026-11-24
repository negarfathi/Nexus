int nondet();

int speedSingleSingle2(int n,int m)
{
  int x,y;
  if(n<0 || m <0) { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
  x=0;y=0;
  while (nondet()>0)
    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
      if (x<n) {x++;y++;} 
      else if (y<m) {x++;y++;}
      else break;
    }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}



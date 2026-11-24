/*exmini*/

int exmini (int i,int j,int k)
{
  int tmp;

  while(i<=100 && j<=k){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    tmp = i;
    i=j;
    j=tmp+1;
    k=k-1;
  }


  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }

}

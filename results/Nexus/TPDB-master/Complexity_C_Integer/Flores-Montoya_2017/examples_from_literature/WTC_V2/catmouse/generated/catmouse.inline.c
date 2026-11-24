

int catmouse(int m,int n){

  int x;
  x=0;
  
  while(x<=n)
    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
      if (x<=m) ++x;
      else --x;
    }
  
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}


// if m<=n does not terminate.

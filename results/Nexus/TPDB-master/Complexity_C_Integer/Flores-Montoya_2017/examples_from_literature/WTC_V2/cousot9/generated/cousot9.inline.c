


int cousot9(int j,int N){

  int i;

  i=N;
  while(i>0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 

    if(j>0) {j--;}
    else
      {
	j=N;i--;
      }

  }

  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

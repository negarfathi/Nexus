int nondet();

int wcet1 (int n) {
  int i,j;

  j=0;
  i=n;
  if (n>=1) 
    do { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
      if (nondet()>0){
	  j++;
	  if(j>=n) j=0;
	}
      else {
	j--;
	if(j<=0) j=0;
      }
      
      i--;
    }
    while(i>0);

  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

int nondet();

int random2d(int N) {
  int x;
  int y;
  int i;
  int r;


  x=0;
  y=0;
  i=0;
  while (i<N) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    i=i+1;
    r=nondet(); 
    if (r>=0 && r<=3) {
    	if (r==0) x=x+1; else
    	if (r==1) x=x-1; else
    	if (r==2) y=y+1; else
    	if (r==3) y=y-1;
    }
  }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

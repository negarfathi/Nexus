

int nondet();

int nd_loop(){
  int x,y;

  x=0;

  do { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    y=x;
    x=nondet();

    if ((x-y>2) || (x-y<1)) break;
  }
  while(x<10);

  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

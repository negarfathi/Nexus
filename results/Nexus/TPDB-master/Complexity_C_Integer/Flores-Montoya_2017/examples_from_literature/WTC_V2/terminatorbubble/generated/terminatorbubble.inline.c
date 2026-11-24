int nondet();


int terminatorbubble(int size) {
  int error;
  int b;
  int j;
  int t;
  error=0;
  b=size;
  if (size>0) {
  while (b>=1) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    if (size<=0) { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_1_IDS_1" ::: "memory"); return 0; }
    j=1;
    t=0;
    while (j<=b-1) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
      if (j<1 || j>size) { { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_2_IDS_1_2" ::: "memory"); return 0; } }
      if (j+1<1 || j+1>size) { { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_2_IDS_1_2" ::: "memory"); return 0; } }
      if (nondet()>0){ t=j;}
      j=j+1;
    }
    if (1>t || t>=b) { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_1_IDS_1" ::: "memory"); return 0; }
    b=t;
  }
  }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

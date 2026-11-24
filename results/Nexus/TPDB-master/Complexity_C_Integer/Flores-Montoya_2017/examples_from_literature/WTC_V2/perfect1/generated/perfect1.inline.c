int perfect1(int x){
  int y1, y2, y3;

  if(x <= 1) { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }

  y1=x;
  y2=x;
  y3=x;

  for(y1 = x-1; y1>0;y1--){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    while(y2 >= y1) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); y2 = y2 - y1; }
    if(y2 == 0)
      y3 = y3 - y1;
    y2 = x;
  }

  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return (y3 == 0); }
}

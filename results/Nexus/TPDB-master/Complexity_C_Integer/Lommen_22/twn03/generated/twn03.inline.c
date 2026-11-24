int twn03(int a, int b, int c) {
  if(a > 0) {
    while(c > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
      a = a + c;
      c = c - 1;
    }
    while(a < b*b) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); 
      a = 5*a + c*c;
      b = 2*b;
    }
  }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

int twn19(int a, int b, int c) {
  if(c > 0) {
    while(a*a + c*c*c*c*c < b && a != 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
      a = -2*a;
      b = 3*b - 2*c*c*c;
      c = c;
    }
  }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

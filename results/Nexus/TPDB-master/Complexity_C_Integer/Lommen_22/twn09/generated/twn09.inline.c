int twn09(int a, int b, int c) {
  if(a > 0) {
    while(c > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        a = a + c;
        c = c - 1;
    }
    if(c <= 0) {
        while(a < b*b) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); 
            c = -2*b;
            a = 5*a;
            c = b + c;
            a = a + c*c*c*c;
            b = 2*b;
            c = b + c;
        }
    }
  }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

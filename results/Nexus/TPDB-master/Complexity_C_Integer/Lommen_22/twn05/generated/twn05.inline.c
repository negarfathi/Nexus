int twn05(int a, int b, int c, int d, int e, int f) {
  if(f > 0) {
    a = d;
    b = e;
    while(f > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
      while(c > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
        a = a + c;
        c = c - 1;
      }
      while(a < b*b && a > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_1" ::: "memory"); 
        a = 5*a + c*c;
        b = 2*b;
      }
      a = d;
      b = e;
      c = f;
      f = f - 1;
    }
  }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

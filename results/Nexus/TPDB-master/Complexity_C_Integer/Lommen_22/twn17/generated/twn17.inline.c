int twn17(int a, int b, int c, int d, int e) {
  while(a > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    b = a;
    c = e;
    if(-5 <= d && d <= 5) {
      while (b != 0 && b*b + d*d*d*d*d < c) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
        b = -2*b;
        c = 3*c - d*d*d;
      }
    }
    else if (d > 0) {
      while (b != 0 && b*b + d*d*d*d*d < c) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_1" ::: "memory"); 
        b = -2*b;
        c = 3*c - d*d*d;
      }
    }
    a = a - 1;
  }
  while(b > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_4_PARENT_0" ::: "memory"); 
    b = b - 1;
  }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

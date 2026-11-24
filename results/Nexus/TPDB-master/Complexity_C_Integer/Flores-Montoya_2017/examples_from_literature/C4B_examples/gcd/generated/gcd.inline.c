/* gcd by substractions */
void gcd(int x, int y) {
  while (x > 0 && y > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    if (x > y)
      x -= y;
    else
      y -= x;
  }
}

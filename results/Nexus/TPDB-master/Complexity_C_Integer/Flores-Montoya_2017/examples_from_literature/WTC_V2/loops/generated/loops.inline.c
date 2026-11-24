

void loops(int n){
  /* n > 0 */
  int x, y;
  
  x = n;
  if(x >= 0)
    while(x >= 0){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
      y = 1;
      if(y < x)
        while(y < x)
          { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); y = 2*y; }
      x = x - 1;
    }

}


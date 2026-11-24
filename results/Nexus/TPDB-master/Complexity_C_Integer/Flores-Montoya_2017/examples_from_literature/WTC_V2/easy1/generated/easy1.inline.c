

void easy1() {
  int x, y;
  int z;
  x=0;
  y=100;
  while (x<40) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    if (z==0) { x=x+1; } else { x=x+2; }
  }
}


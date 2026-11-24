

void sipma91(int x){
  int y1, y2, z;

  y1 = x;
  y2 = 1;

  if(y1 > 100) z = y1 - 10;
  else {
    while(y1 <= 100){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
      y1 = y1 + 11;
      y2 = y2 + 1;
    }

    while(y2 > 1){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); 
      y1 = y1 - 10;
      y2 = y2 - 1;
      if(y1 > 100 && y2 == 1) z = y1 - 10;
      else {
	if(y1 > 100){
          y1 = y1 - 10;
          y2 = y2 - 1;
        }
        y1 = y1 + 11;
        y2 = y2 + 1;
      }
    }
  }
}

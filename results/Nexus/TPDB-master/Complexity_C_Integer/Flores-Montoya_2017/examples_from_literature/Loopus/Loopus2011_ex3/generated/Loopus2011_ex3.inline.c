
void Loopus2011_ex3(int x, int b){
 while (0 < x && x < 255){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
  if (b) x = x + 1;
   else x = x - 1; 
 }
}


int nondet();
void tick(int c);

void ex_paper1(int x,int y,int z){
if(x<=0) { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return; }
if(y<=0) { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return; }
 while(x>0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
   x--;
   y++;
 while(nondet() && y>0){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
     y--;   
     tick(2);
   }
 }
  while(y>0){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_0" ::: "memory"); 
    y--; 
    for(int i=0;i<z;i++)
       { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_4_PARENT_3" ::: "memory"); tick(1); }
  }
   
}

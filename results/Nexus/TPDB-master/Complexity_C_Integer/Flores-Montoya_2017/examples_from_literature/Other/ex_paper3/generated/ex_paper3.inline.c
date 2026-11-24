int nondet();


void exp_paper3(int x,int y, int z){
 while(x>0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
   if(nondet()>0){
     while(nondet()>0 && y>0 ){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
        y--;   
        
     }
   }else{
   if(nondet()>0)
       y++;
   else
       y=z;
   }
  x--;
 }

}

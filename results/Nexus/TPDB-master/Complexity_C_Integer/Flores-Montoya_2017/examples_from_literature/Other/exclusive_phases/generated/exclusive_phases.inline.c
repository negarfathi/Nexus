
int nondet();
void ex_paper1(int i,int n,int fwd){

 while(0<i && i<n){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
   if(fwd>0)
     ++i;
   else
     --i;
 }
  
   
}

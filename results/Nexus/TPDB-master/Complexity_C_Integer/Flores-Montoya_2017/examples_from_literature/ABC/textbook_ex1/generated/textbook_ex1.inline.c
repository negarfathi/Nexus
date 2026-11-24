void textbook_ex1(int a,int b){
int i;
for(i= a;i<=b;i=i+ 1)
         { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); ; }
}

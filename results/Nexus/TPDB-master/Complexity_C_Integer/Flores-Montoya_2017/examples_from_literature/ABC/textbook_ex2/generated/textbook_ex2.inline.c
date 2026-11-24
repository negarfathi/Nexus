void textbook_ex2(int n){
   int i,j;
for( i= 0;i<=n-1;i=i+ 1)
  { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); for(j= 0;j<=i;j=j+ 1)
         { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); ; } }
}

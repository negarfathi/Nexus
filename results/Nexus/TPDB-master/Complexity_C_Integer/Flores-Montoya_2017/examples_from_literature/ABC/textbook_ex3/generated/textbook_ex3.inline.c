void textbook_ex3(int m){
 int i,j,k,l;
for(i= 1;i<=m;i=i+ 1)
  { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); for(j= 1;j<=i;j=j+ 1)
    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); for(k= i+1;k<=m;k=k+ 1)
      { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_2" ::: "memory"); for(l= 1;l<=k;l=l+ 1)
         { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_4_PARENT_3" ::: "memory"); ; } } } }
}

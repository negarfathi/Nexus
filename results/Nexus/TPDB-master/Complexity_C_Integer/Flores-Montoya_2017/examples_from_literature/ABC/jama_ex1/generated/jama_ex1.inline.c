void jama_ex1(int n){
for(int i= 1;i<=n;i=i+ 1)
  { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); for(int j= 1;j<=n;j=j+ 1)
     { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); ; } }

}


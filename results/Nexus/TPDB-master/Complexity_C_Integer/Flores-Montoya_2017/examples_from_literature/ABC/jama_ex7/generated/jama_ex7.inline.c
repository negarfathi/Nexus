void jama_ex7(int n,int m){
int i,j;
for(i=n;i>=1;i--)
  { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); for(j=m;j>=1;j--)
    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); ; } }
}

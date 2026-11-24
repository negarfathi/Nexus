void jama_ex5(int n){
int i,j;
for(i=0;i<=n;i=i+2)
  { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); for(j=0;j<=n;j=j+2)
    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); ; } }
}

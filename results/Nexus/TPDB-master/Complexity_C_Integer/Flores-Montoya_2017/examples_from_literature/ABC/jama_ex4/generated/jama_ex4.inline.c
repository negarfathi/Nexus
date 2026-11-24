void jama_ex4(int a,int b,int c, int d){
for(int i=a;i<=b;i++)
  { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); for(int j=c;j<=d;j++)
    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); ; } }
}

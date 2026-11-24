void jama_ex6(int a,int b,int c, int d){
int i,j,k;
for( i=a;i<=b;i++)
  { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); for( j=c;j<=d;j++)
    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); for(k=i-j;k<=i+j;k++)
    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_2" ::: "memory"); ; } } }
}

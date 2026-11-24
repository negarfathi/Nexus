void textbook_ex4(int m,int n){
 int j,i;
for(j= 1;j<=n;j=j+ 1)
  { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); for(i= 1;i<=m;i=i+ 1)
	{ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); ; } }
}

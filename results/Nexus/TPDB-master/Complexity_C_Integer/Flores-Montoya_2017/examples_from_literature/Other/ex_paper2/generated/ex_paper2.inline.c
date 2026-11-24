

void ex_paper2(int n){
for(int x= 1;x<=n;x++)
  { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); for(int y=x;y<=n;y++)
    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); ; } }
}

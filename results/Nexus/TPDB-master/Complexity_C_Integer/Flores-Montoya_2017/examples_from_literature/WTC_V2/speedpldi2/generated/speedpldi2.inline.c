

void speedpldi2(int n, int m){
  int v1, v2;
  if(n>=0 && m>0){

  V1N:  v1 = n;
  V2Z:  v2 = 0;
  WH:  while(v1 > 0)
    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); I:  if(v2<m){
      P:  ++v2;
      M:  --v1;
    } else 
      ZZ: v2 = 0; }
  }
}

int nondet();

void serpent(int n){
  int x, y;
  if(n <= 0) { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return; }
  y=n; x=n;
  while(x >= 0){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
W1: while(y>=0 && nondet()>0){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
      --y;
    }
    --x;
W2: while(y<=n && nondet()>0){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_1" ::: "memory"); 
      ++y;
    }
  }
}

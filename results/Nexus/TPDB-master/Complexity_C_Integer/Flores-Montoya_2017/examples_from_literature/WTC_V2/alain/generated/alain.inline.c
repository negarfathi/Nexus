
int alain(int x,int y,int z,int n1,int n2)
{

  int c1, c2;
  c1 = 0;
  if(n2 <= 2*y) { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
  if(n2 <= z+y) { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
  if(z>=0 && x>=0 && y>=0 && n1>=0 && n2>=0)
    {
      while(--n1 >= 0 )
	{ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
          c2 = 0;
          ++c1;
	  while(n2 > 0)
	    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
	      --n2;
	      z = y;
              ++c2;
	    }
	  z = z+y;
	  n2 = z;
	}
    }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

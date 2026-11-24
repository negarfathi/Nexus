int nondet();

int speedFails3(int x,int n,int t){
  int b=nondet();

  while(x>=0 && x<=n)
    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
      if(b>0)
	{
	  x=x+t;
	}
      else
	{
	  x=x-t;
	}

    }
  
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

int nondet();

int rsd (int r)
{

  int da,db,temp;
  int c1;
  c1=0;
  if (r>=0){
    da = 2*r;
    db = 2*r;
    while (da >=r) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
      if (nondet()>0){
	da --;
      }
      else{
	temp = da;
	da = db - 1;
	db = temp;
      }
      c1++;
    }
  }

  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }

  
}

//taken from SPEC CPU2006	gromacs/src/index.c 	analyse_other

int random();

//O(n^3)
void analyse_other(int atoms_nres, int atoms_nr, int bASK)
{
  int restp=0;
  int  i,j,k,l,resnr,naid,naaid,natp,nrestp=0;

  //O(n)  
  for(i=0; (i<atoms_nres); i++)
    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); if (random())
      break; }
  if (i < atoms_nres) {
    //O(n^2)
    for(k=0; (k<atoms_nr); k++) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); 
      if (random()) {
	for(l=0; (l<nrestp); l++)
	  { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_2" ::: "memory"); if (random())
	    break; }
	if (l==nrestp) {
	  ++nrestp;
	}
      }
    }
    //O(n^3)
    for(i=0; (i<nrestp); i++) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_4_PARENT_0" ::: "memory"); 
      naid=0;
      for(j=0; (j<atoms_nr); j++) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_5_PARENT_4" ::: "memory"); 
	if (random()) 
	  naid++;
      }
      if (bASK) {
	if (random()) {
	  natp=0;
	  for(k=0; (k<naid); k++) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_6_PARENT_4" ::: "memory"); 
	    for(l=0; (l<natp); l++)
	      { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_7_PARENT_6" ::: "memory"); if (random())
		break; }
	    if (l == natp) {
	      ++natp;
	    }
	  }
	  if (natp > 1) {
	    for(l=0; (l<natp); l++) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_8_PARENT_4" ::: "memory"); 
	      naaid=0;
	      for(k=0; (k<naid); k++) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_9_PARENT_8" ::: "memory"); 
		if (random()) 
		  naaid++;
	      }
	    }
	  }
	}
      }
    }
  }
}


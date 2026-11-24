int nondet();


void Loopus2011_ex1(int n){
int i = 0; int j;

 while(i < n){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
	i++; j = 0;
	while((i < n) && nondet()>0){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
		i++; j++;
	}
	if (j > 0)
		i--;
 }
}

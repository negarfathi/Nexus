int nondet();


void Loopus2014_ex1(int n){
int a = n, b = 0;
while (a > 0){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
	a--; b++;
	while (b > 0){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
		b--;
		for (int i = n-1; i > 0; i--)
			{ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_2" ::: "memory"); if (a > 0 && nondet()>0){
				a--; b++;
			} }  
		} 
	 }
}

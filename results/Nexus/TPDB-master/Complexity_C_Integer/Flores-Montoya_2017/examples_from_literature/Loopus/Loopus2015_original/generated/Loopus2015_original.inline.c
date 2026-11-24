
int nondet();

void Loopus2015_original(int len)
{
int beg=0;int end=0;int i=0;
 while(i < len){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
 i++;
 if (nondet()>0)
   end = i;
 if (nondet()>0){
   int k = beg;
   while (k < end){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
	k++;
   }
   end = i;
   beg = end;
   }
 }
}



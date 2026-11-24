 int nondet();

void real2(int len)
 {
   //int tab[10];
   int   tmp;
   int   again;
   int   i;
 
   for (again = 1; again;)
     { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); for (again = 0, i = 0; i < (len - 1); i++)
       { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
         if (nondet() > nondet())
           {
             tmp = nondet();//tab[i];
             ;//tab[i] = tab[i + 1];
             ;//tab[i + 1] = tmp;
             again = 1;
           }
       } }
 }

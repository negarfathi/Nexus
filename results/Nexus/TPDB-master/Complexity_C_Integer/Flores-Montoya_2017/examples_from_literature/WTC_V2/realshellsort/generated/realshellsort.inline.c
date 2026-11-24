int nondet();

//realshellsort (avec -delay 3)
void realshellsort(int array_size)//,int numbers[])
{
  int i, j, increment, temp;

  increment = array_size / 2;
  while (increment > 0)
  { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    for (i=0; i < array_size; i++)
    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
      j = i;
      temp = nondet();//numbers[i];
      while ((j >= increment) && (nondet() > temp))
      { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_2" ::: "memory"); 
        ;//numbers[j] = numbers[j - increment];
        j = j - increment;
      }
      ;//numbers[j] = temp;
    }

    increment = increment/2;
  }
}

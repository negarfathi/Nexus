 int nondet();

void realbubble(int length)
{
  //int *array;
  int i, j, temp;
  int test; /*use this only if unsure whether the list is already sorted or not*/

  for(i = length - 1; i > 0; i--)
  { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    test=0;
    for(j = 0; j < i; j++)
    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
      if(nondet() > nondet()) /* compare neighboring elements */
      {
        temp = nondet();    /* swap array[j] and array[j+1] */
        ;//array[j] = array[j+1];
        ;//array[j+1] = temp;
        test=1;
      }
    } /*end for j*/
    if(test==0) break; /*will exit if the list is sorted!*/
  } /*end for i*/
      
}/*end bubbleSort*/

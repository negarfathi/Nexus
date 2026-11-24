int nondet();

void sipmamergesort2(int n){//int a[]){
  int i, j, k, l, t;
  int h, m, p, q, r;
  int up;              /* really boolean */
 // int a[2*n+1];

  up = 1;
  p = 1;

  do{ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    h = 1;
    m = n;
    //up==0
    
    k = 1;
    l = n;
    i = n+1;
    j = 2*n;
    

    do{ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
      if(m >= p)
	q = p;
      else q = m;
      m = m-q;
      if(m >= p)
        r = p;
      else r = m;
      m = m-r;

      while(q>0 && r>0)
        { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_2" ::: "memory"); if(nondet()>0){
          //a[k] = a[i];
          k = k+h;
          i = i+1;
          q = q-1;
        } else {
          //a[k] = a[j];
          k = k+h;
          j = j-1;
          r = r-1;
        } }
    
      while(r > 0){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_4_PARENT_2" ::: "memory"); 
        //a[k] = a[j];
        k = k+h;
        j = j-1;
        r = r-1;
      }

      while(q > 0){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_5_PARENT_2" ::: "memory"); 
        //a[k] = a[i];
        k = k+h;
        i = i+1;
        q = q-1;
      }

      h = -h;
      t = k;
      k = l;
      l = t;
    } while(m > 0);
    up = 0;
    p = 2*p;
    
    // fin up==1
    if (p>=n) break;
    //up ==0
    h = 1;
    m = n;
    
    i = 1;
    j = n;
    k = n+1;
    l = 2*n;
    
    do{ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_6_PARENT_1" ::: "memory"); 
      if(m >= p)
	q = p;
      else q = m;
      m = m-q;
      if(m >= p)
        r = p;
      else r = m;
      m = m-r;
      
      while(q>0 && r>0)
        { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_7_PARENT_6" ::: "memory"); if(nondet()>0){
          //a[k] = a[i];
          k = k+h;
          i = i+1;
          q = q-1;
        } else {
          //a[k] = a[j];
          k = k+h;
          j = j-1;
          r = r-1;
        } }
    
      while(r > 0){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_8_PARENT_6" ::: "memory"); 
        //a[k] = a[j];
        k = k+h;
        j = j-1;
        r = r-1;
      }

      while(q > 0){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_9_PARENT_6" ::: "memory"); 
        //a[k] = a[i];
        k = k+h;
        i = i+1;
        q = q-1;
      }

      h = -h;
      t = k;
      k = l;
      l = t;
    } while(m > 0);
    up = 1;
    p = 2*p;

    
  } while(p<n);


  // fin 


  if(up == 0){ // recopie
    i = 1;
    while(i <= n){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_10_PARENT_0" ::: "memory"); 
      //a[i] = a[i+n];
      i = i+1;
    }
  }

}
        
      

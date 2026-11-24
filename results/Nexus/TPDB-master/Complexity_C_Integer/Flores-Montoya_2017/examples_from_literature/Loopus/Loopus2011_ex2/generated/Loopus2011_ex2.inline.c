int nondet();


void Loopus2011_ex2(int r, int s) {
int c = 4; int n; int f = 0; int d = 0;
do { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
  n = nondet();
  if (c == 1 ) break;
  if (f) c /= 2;
  if (n > r) {
    if (d == 1 && !f) {f = 1; c /= 2; }
    d = 2; s += c;
    if (s > 255) break; }
  else if (n < r) {
    if (d == 2 && !f) {f = 1; c /= 2; }
    d = 1; s -= c;
    if (s < 0) break; }
  else break; }
while (1); 
}

#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

#define THREAD 10000

void * func(void *arg){
 usleep(1000000);
 return NULL;
}
int main(){
pthread_t threads[THREAD];

for (int i=0;i<THREAD;i++){
pthread_create(&threads[i], NULL, func, NULL);
}
for (int i = 0; i < THREAD; i++) {
pthread_join(threads[i], NULL);
}


return 0;
}

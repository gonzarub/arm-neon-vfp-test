#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

typedef double msec_t;
#define VECTOR_SIZE 32
msec_t time_msec(void) {
        struct timeval now_tv;
        gettimeofday(&now_tv, NULL);
        return (msec_t)now_tv.tv_sec * (msec_t)1000 + now_tv.tv_usec / (msec_t)1000;
}

int main(int argc, char *argv[]) {
        if(argc != 4) exit(1);
        volatile double f1 = atof(argv[1]);
        volatile double f2 = atof(argv[2]);
        volatile double ans = 1.0;
        long iterations = atoi(argv[3]) * 1;

	volatile double vec_f1[VECTOR_SIZE];
	volatile double vec_f2[VECTOR_SIZE];

	for (int i=0; i< VECTOR_SIZE; i++) {
	  vec_f1[i] = f1;
	  vec_f2[i] = f2;
	}

        msec_t start = time_msec();

        for(int i=0; i<iterations; i++) {
	  for (int j=0; j< VECTOR_SIZE; j++) {
	    ans += vec_f1[j] * vec_f2[j];
	  }
          //if(i < 10)
            //printf("%d ans = %f\n", i, ans);
        }
        msec_t end = time_msec();

	int exec_time = (int)(iterations/(end - start));
        //printf("ans = %f %d loop/msec\n", ans, (int)(iterations/(end - start)));
	//printf("%10s:\t%d loop/msec\n", argv[0], (int)(iterations/(end - start)) );
	printf("%20s: %f  %d loop/msec\n", argv[0], ans,  exec_time);
        return 0;
}

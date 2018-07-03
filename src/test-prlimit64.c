#define __USE_LARGEFILE64 1
#include <sys/time.h>
#include <sys/resource.h>
#include <stdio.h>


int
main(void)
{
	struct rlimit limits;
	int ret;


	ret = prlimit64(0, RLIMIT_AS, NULL, &limits);
	if (ret != 0)
	{
		perror("prlimit(RLIMIT_AS)");
		return 1;
	}
	printf("%ld/%ld\n", limits.rlim_cur, limits.rlim_max);

	return 0;
}

#define _GNU_SOURCE
#include <sys/time.h>
#include <sys/resource.h>
#include <sys/syscall.h>
#include <signal.h>
#include <errno.h>
#include <stdint.h>

#include <unistd.h>
#include <stdio.h>

extern int
setrlimit(__rlimit_resource_t resource,
	const struct rlimit *rlimits)
{
	int ret;
	ret = syscall(SYS_setrlimit, resource, rlimits);

	return ret;
}

extern int
setrlimit64(__rlimit_resource_t resource,
	const struct rlimit64 *rlimits64)
{
	struct rlimit rlimits;

	rlimits.rlim_cur = rlimits64->rlim_cur;
	rlimits.rlim_max = rlimits64->rlim_max;
	return setrlimit(resource, &rlimits);
}

extern int
getrlimit(__rlimit_resource_t resource,
	struct rlimit *rlimits)
{
	int ret;
	ret = syscall(SYS_getrlimit, resource, rlimits);

	return ret;
}

extern int
getrlimit64(__rlimit_resource_t resource,
	struct rlimit64 *rlimits64)
{
	int ret;
	struct rlimit rlimits;

	ret = getrlimit(resource, &rlimits);
	rlimits64->rlim_cur = rlimits.rlim_cur;
	rlimits64->rlim_max = rlimits.rlim_max;
	return ret;
}

extern int
prlimit64(__pid_t pid, enum __rlimit_resource resource,
	const struct rlimit64 *new_limit,
	struct rlimit64 *old_limit)
{
	int ret;

	//printf("prlimit64(%d, ...)...\n", pid);
	if (pid == 0)
	{
		if (old_limit != NULL)
		{
			ret = getrlimit64(resource, old_limit);
			if (ret != 0)
			{
				return ret;
			}
		}
		if (new_limit != NULL)
		{
			setrlimit64(resource, new_limit);
			if (ret != 0)
			{
				return ret;
			}
		}
		errno = 0;
		return 0;
	}
	else
	{
		ret = kill(pid, 0);
		if (ret != 0)
		{
			return ret;
		}
		if (old_limit != NULL)
		{
			ret = getrlimit64(resource, old_limit);
			if (ret != 0)
			{
				return ret;
			}
		}
	}
	return 0;
}

extern int
prlimit(__pid_t pid, enum __rlimit_resource resource,
	const struct rlimit *new_limit,
	struct rlimit *old_limit)
{
	int ret;

	//printf("prlimit(%d, ...)...\n", pid);
	if (pid == 0)
	{
		if (old_limit != NULL)
		{
			ret = getrlimit(resource, old_limit);
			if (ret != 0)
			{
				return ret;
			}
		}
		if (new_limit != NULL)
		{
			setrlimit(resource, new_limit);
			if (ret != 0)
			{
				return ret;
			}
		}
		errno = 0;
		return 0;
	}
	else
	{
		ret = kill(pid, 0);
		if (ret != 0)
		{
			return ret;
		}
		if (old_limit != NULL)
		{
			ret = getrlimit(resource, old_limit);
			if (ret != 0)
			{
				return ret;
			}
		}
	}
	return 0;
}

void
_init(void)
{
	//write(1, "Init...\n", 8);
	//printf("Init(%d)...\n", getpid());
}

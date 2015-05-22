
#include <sys/cdefs.h>

#include <sys/types.h>
#include <assert.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <locale.h>
#include <libutil.h>
#include <pwd.h>
#include <grp.h>

const char* user_from_uid(uid_t uid, int nouser) {
	struct passwd* user_pw = getpwuid(uid);
	char* uid_rep = (char*)malloc(30);
	if (user_pw==NULL) {
		if (nouser==0) {
			snprintf(uid_rep, 30, "%d", uid);
			return (const char*)uid_rep;
		} else {
			return NULL;
		}
	}
	return (const char*)user_pw->pw_name;
}

const char* group_from_gid(gid_t gid, int nogroup) {
	struct group* group_info = getgrgid(gid);
	
	char* gid_rep = (char*)malloc(30);
        if (group_info==NULL) {
		if (nogroup==0) {
			snprintf(gid_rep, 30, "%d", gid);
			return (const char*)gid_rep;
		} else {
			return NULL;
		}
	}
	return (const char*)group_info->gr_name;
}

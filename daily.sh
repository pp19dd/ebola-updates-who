#!/bin/bash

if [ -z "$email" ]; then echo "ERROR: email variable not set"; exit; fi
if [ -z "$folder" ]; then echo "ERROR: folder variable not set"; exit; fi
if [ -z "$url" ]; then echo "ERROR: url variable not set"; exit; fi

wget \
	"${url}" \
	-O "${folder}/current.dat"

/usr/bin/php ${folder}/parse.php "${folder}/current.dat" > "${folder}/current.reduced.dat"
/usr/bin/php ${folder}/parse.php "${folder}/previous.dat" > "${folder}/previous.reduced.dat"

# compare current and previous files
current=`/usr/bin/md5sum "${folder}/current.reduced.dat" | /bin/cut -f1 -d' '`
previous=`/usr/bin/md5sum "${folder}/previous.reduced.dat" | /bin/cut -f1 -d' '`
date=`/bin/date`

# if current file is empty, alert user
if [ ! -s current.reduced.dat ]
then
	/bin/mail \
		-s "ebola update ${date} WARNING EMPTY" \
	 	"${email}" \
		< "${folder}/current.reduced.dat"
	exit
fi

# if current and previous are identical, exit
if [ "${current}" == "${previous}" ]
then
	exit
fi

# otherwise, update previous to look like current, email admin
/bin/cp "${folder}/current.dat" "${folder}/previous.dat"

/bin/mail \
	-s "ebola update ${current} ${date}" \
	 "${email}" \
	< "${folder}/current.reduced.dat"
